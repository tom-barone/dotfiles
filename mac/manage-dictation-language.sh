#!/bin/bash
#
summary="manage macOS dictation language"
#
# Modified from https://stackoverflow.com/questions/11680778/how-to-use-applescript-to-toggle-the-language-setting-of-new-dictation-tool-10

#
# Variables
# ---------

langA=en_AU
langB=it_IT

#
# Options
# -------

cmd=$(basename $0)
usage="$cmd -h | {-g | -s lang | -t}"

prefs="com.apple.speech.recognition.AppleSpeechRecognition.prefs"
#key="DictationIMLocaleIdentifier"
key_locale="DictationIMNetworkBasedLocaleIdentifier"
key_order="DictationIMPreferredLanguageIdentifiers"

#
# The following keys change in prefs when I change the language in the dictation popup:
#
#   DictationIMNetworkBasedLocaleIdentifier = "en_US";   <- changes to "de_DE"
#   DictationIMPreferredLanguageIdentifiers =     (      <- changes order of preference
#       "en_US",
#       "de_DE"
#   );


help=$(cat <<EOF

  $cmd -- $summary

  $usage

  Options:
    -h            display this help
    -g            get current language
    -s lang       set current language to <lang>
    -t            toggle the language between $langA and $langB (edit script to change)
   
EOF
)


while getopts hgs:t OPT
do
  case $OPT in
    h) echo "$help" >&2
       exit 0
       ;;
    g) defaults read "$prefs" "$key_locale" >&2
       exit 0
       ;;
    s) lang=$OPTARG
       ;;
    t) toggle=1
       ;;
    \?) echo $usage >&2
        exit 2
        ;;
  esac
done

#shift $(expr $OPTIND - 1)

test $# -eq 0 && echo -e "Nothing to do. Usage:\n\n    $usage\n" && exit 0


#
# Run


if [ "$lang" = "" ]                     # treat not setting a language as toggle
then                                    # toggle
  cur="$(defaults read "$prefs" "$key_locale")"
  case "$cur" in
    "$langA") lang1="$langB"; lang2="$langA" ;;
    "$langB") lang1="$langA"; lang2="$langB" ;;
    *) echo "current language '$cur' is not one of '$langA' or '$langB'" >&2
       exit 2
       ;;
  esac
else                                    # set language
  case "$lang" in
    "$langA") lang1="$langA"; lang2="$langB" ;;
    "$langB") lang1="$langB"; lang2="$langA" ;;
    *) echo "language '$lang' is not one of '$langA' or '$langB'" >&2
       exit 2
       ;;
  esac
fi

defaults write "$prefs" "$key_locale" "$lang1"
defaults write "$prefs" "$key_order" "($lang1, $lang2)"

# Not used
#defaults write com.apple.assistant "Session Language" "$lang"

# DictationIM is the Input Method-based process that implements the UI
# portion of the Dictation feature in macOS. If it doesn't exist, it will
# launch automatically, so don't error here
killall -HUP DictationIM 2>/dev/null || true



#
# EOF
