
DIR=`pwd`
find -L $DIR/src $DIR/test $DIR/include -name "*.erl" -o -name "*.hrl" > $DIR/cscope_source.files
cscope -bq -i $DIR/cscope_source.files  -f cscope_source.out


#ctags -R *.erl *.hrl

FILE="$DIR/src $DIR/test $DIR/include"

for i in $FILE
do
	cp .vimrc $i
done

