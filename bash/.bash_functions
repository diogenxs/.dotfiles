#
# FUNCTIONS
# ex - archive extractor
# usage: ex <file>
ex () {
if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "usage: ex <file>"
fi
}

ghooks () {
    if [ ! -d "$PWD/.git" ] ; then
        echo "Not a git repo"
        return 1
    fi
    
    if [ $# -eq 0 ] ; then
        echo "usage: ghooks <hook-name>"
        echo "options:"
        echo "    terraform - generate a terraform pre-commit hook to format .tf files"
        return 1
    fi
    case $1 in
        terraform)
            if ! command -v terraform &> /dev/null
            then
                echo "terraform could not be found in $PATH"
                return 1
            fi
            echo "terraform fmt -recursive" >> .git/hooks/pre-commit
            shift ;;
        *) echo "Invalid option: $1"; return 1 ;;
    esac
}

tf-mv-resource() {
    [[ $# -eq 0 ]] && { echo "Pass the .tf file to import to the current dir"; return 0; }
    TMP_FILE=$PWD/$1;
    TMP_DIR=$(dirname $TMP_FILE)
    FILE=$PWD/$(basename $TMP_FILE)
    TF=$(which terraform)

    [[ -f "$TMP_DIR/terraform.tfstate" ]] || { echo >&2 "No tfstate in dst dir"; return 1; }
    [[ "$PWD" == "$TMP_DIR" ]] && { echo >&2 "src and dest dirs cannot be the same"; return 1; }
    [[ -f "$TMP_FILE" ]] || { echo >&2 "$TMP_FILE not exists"; return 1; }

    if [ ! -f "$PWD/terraform.tfstate" ]; then
        $TF apply
    fi

    RE_RSC_NAME='s/-002(D|E)-/-/g;s/(tfer--)|(-00\w{2}-)//gm;t'
    RE_RSC='s/data\.terraform_remote_state\.local\.outputs\.(\w*)(_tfer--)([a-zA-Z0-9_-]*)_(\w+)/\1\.\3\.\4/gm;t'
    
    for i in $(grep -E "^(\s|)resource" $TMP_FILE | awk '{gsub("\"",""); print $2"."$3;}')
    do
        RSC_NAME=`echo $i | sed -E $RE_RSC_NAME`
        $TF state mv -state="$TMP_DIR/terraform.tfstate" -state-out="$PWD/terraform.tfstate" "$i" "$RSC_NAME"
    done
    

    cat $TMP_FILE | grep -v "^#" | sed -E $RE_RSC | sed -E $RE_RSC_NAME >> $FILE
    rm $TMP_DIR/terraform.tfstate.*.backup
    rm $PWD/terraform.tfstate.*.backup
}

tf-graph() {
    TMP_FILE=$(mktemp --suffix=.svg)
    $(which terraform) graph --draw-cycles "$@" | dot -Tsvg > $TMP_FILE && $(which kgraphviewer) $TMP_FILE &
}

git-ignore() {
    curl https://www.toptal.com/developers/gitignore/api/$1 > .gitignore
}
