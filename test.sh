BUILD="sudo docker run --rm -v $PWD:/src -w /src haskell:7.10.3 ghc -o ./a.out -O2 ./Main.hs"
DEBUG="sudo docker run --rm -v $PWD:/src -w /src haskell:7.10.3 ghc -o ./a.out -O2 ./Main.hs"

echo "Building..."
if [ "$1" = "debug" ]; then
    echo $DEBUG
    $DEBUG
else
    echo $BUILD
    $BUILD
fi


if [ ! $? = 0 ]; then
    echo "Build failed."
    exit
fi

echo "Removing old output..."
mkdir -p output
rm output/*

for file in `ls input`; do
    echo -n "Testing $file..."
    timeout 5 ./a.out < input/$file > output/$file 2>&1
    if diff -q output/$file answer/$file > /dev/null; then
        echo "passed."
    else
        echo "failed."
    fi
done

for file in `ls input`; do
    bat output/$file
done

rm -f a.out
