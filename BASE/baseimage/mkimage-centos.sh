#!/usr/bin/env bash
#
# Create a base CentOS Docker image.
#
# This script is useful on systems with yum installed (e.g., building
# a CentOS image on CentOS).  See contrib/mkimage-rinse.sh for a way
# to build CentOS images on other systems.

usage() {
    cat <<EOOPTS
$(basename $0) [OPTIONS] <name>
OPTIONS:
  -y <yumconf>  The path to the yum config to install packages from. The
                default is /etc/yum.conf.
  -p <pckg_list>  The packages install in the tempdir.
  -g <group_list>  The group install in the tempdir(not used now).
EOOPTS
    exit 1
}

# option defaults
yum_config=/etc/yum.conf
while getopts ":y:p:g:h" opt; do
    case $opt in
        y)
            yum_config=$OPTARG
            ;;
        p)
            pckg_list=$OPTARG
            ;;
        g)
            group_list=$OPTARG
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
    esac
done
shift $((OPTIND - 1))
name=$1

if [[ -z $name ]]; then
    usage
fi

if [ -z "$pckg_list" ]; then
    echo "Package list is empty, It will install Core_Group only."
    echo "set -p option specify the package list file."
fi


target=$(mktemp -d --tmpdir $(basename $0).XXXXXX)

set -x

mkdir -m 755 "$target"/dev
mknod -m 600 "$target"/dev/console c 5 1
mknod -m 600 "$target"/dev/initctl p
mknod -m 666 "$target"/dev/full c 1 7
mknod -m 666 "$target"/dev/null c 1 3
mknod -m 666 "$target"/dev/ptmx c 5 2
mknod -m 666 "$target"/dev/random c 1 8
mknod -m 666 "$target"/dev/tty c 5 0
mknod -m 666 "$target"/dev/tty0 c 4 0
mknod -m 666 "$target"/dev/urandom c 1 9
mknod -m 666 "$target"/dev/zero c 1 5


## install centos-release first.
#rpm -qa | grep yum-utils
#ret=$?
#if [ ret != 0 ]; then
#    yum install -y yum-utils
#fi
#yumdownloader centos-release
#rpm -ivh --root="$target" ./centos-release*.rpm

# install Core_group and your package list.
yum -c "$yum_config" --installroot="$target" --setopt=tsflags=nodocs \
    --setopt=group_package_types=mandatory -y groupinstall Core $group_list 
if [ -n "$pckg_list" ];then
    yum -c "$yum_config" --installroot="$target" install -y $pckg_list
fi
yum -c "$yum_config" --installroot="$target" -y clean all


cat > "$target"/etc/sysconfig/network <<EOF
NETWORKING=yes
HOSTNAME=localhost.localdomain
EOF

# effectively: febootstrap-minimize --keep-zoneinfo --keep-rpmdb
# --keep-services "$target".  Stolen from mkimage-rinse.sh
#  locales
rm -rf "$target"/usr/{{lib,share}/locale,{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive}
#  docs
rm -rf "$target"/usr/share/{man,doc,info,gnome/help}
#  cracklib
rm -rf "$target"/usr/share/cracklib
#  i18n
rm -rf "$target"/usr/share/i18n
#  sln
rm -rf "$target"/sbin/sln
#  ldconfig
rm -rf "$target"/etc/ld.so.cache
rm -rf "$target"/var/cache/ldconfig/*


tar --numeric-owner -c -C "$target" . | docker import - $name
docker run -i -t $name:$version echo success

rm -rf "$target"
