# Don't upgrade if installed on internal
for arg in $(cat /proc/cmdline); do
   case ${arg} in
     bootfrom*)
       bootfromext=1
       ;;
  esac
done

if [ "$bootfromext" = "1"]; then
  exit 0
else
  echo "This release only supports upgrading from devices booted from an external device i.e USB Drive/SD card"
  exit 1
fi
