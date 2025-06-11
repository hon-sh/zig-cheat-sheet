
set -e

rm -rf dist && mkdir -p dist
typst compile main.typ 'dist/p{0p}.svg'
echo '<style> img {width: 100%} </style>' > dist/index.html
cd dist && for f in *.svg; do (echo "<img src=\"$f\" />" >> index.html); done 
