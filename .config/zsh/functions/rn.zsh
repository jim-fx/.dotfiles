function rn(){
  find . -name "*.$1" -exec sh -c 'mv "$0" "${0%.'$1'}.'$2'"' {} \;
}