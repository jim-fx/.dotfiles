function mv-safe(){
  for OLD_NAME in "$@"
  do
    NEW_NAME="$(echo $OLD_NAME | sed -e 'y/āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ/aaaaeeeeiiiioooouuuuüüüüAAAAEEEEIIIIOOOOUUUUÜÜÜÜ/' | sed -e 's/[^A-Za-z0-9._-]/_/g')"
    if [ $OLD_NAME != $NEW_NAME ]; then
      mv $OLD_NAME $NEW_NAME;
    else
      echo "No need to rename $OLD_NAME";
    fi
  done
}
