
dnl Process this file with autoconf to produce a configure script.
AC_PREREQ(2.59)

dnl Set the package version
dnl Don't forget to update the PACKAGE, VERSION and BUILDINFO macros in
dnl win95/microsft/config.h to keep the native Microsoft C++
dnl compiler build happy. 
AC_INIT(dmake, 4.13)
AC_CANONICAL_BUILD
BUILDINFO="$build"

AC_CONFIG_SRCDIR(man/dmake.tf)
AM_INIT_AUTOMAKE

AM_MAINTAINER_MODE
dnl Use this instead of AC_PROG_.. version
AM_PROG_CC_C_O

AC_CONFIG_HEADER(config.h)

dnl Extra parameters
AC_ARG_ENABLE(dbug,
[  --enable-dbug:          Enable build with dbug macros.
],,)

AC_ARG_ENABLE(spawn,
[  --enable-spawn:         Enables the use of spawn instead of fork/exec
                          if it is supported.
],,)
dnl Checks for programs.
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB

dnl Checks for utilities.
AC_PROG_AWK

dnl Checks for OS
AC_MSG_CHECKING([the operating system])

_os=`uname`

if test `echo $_os | $AWK -F_ '{ print $1 }'` = "CYGWIN"; then
   if test "$GCC" = "yes"; then
      if gcc -dumpmachine | grep -i "mingw"; then
         _os="MINGW"
      else
         _os="CYGWIN"
      fi
   else
      _os="MSVC6"
   fi
fi


## At the moment all except mingw builds are OS_TYPE unix
OS_TYPE=unix

## The following allows like systems to share settings this is not meant to
## Imply that these OS are the same thing.
case "$_os" in
	"OS/2")
	  OS_VERSION=os2
	  CASE_INSENSITIVE_FS=true
	  ;;
	"SunOS")
	  OS_VERSION=solaris  
	  ;;
	Linux|GNU|GNU/*)
	  OS_VERSION=linux
	  ;;
	"CYGWIN")
	  OS_VERSION=cygwin
	  CASE_INSENSITIVE_FS=true
	  ;;
	MINGW*)
	  OS_VERSION=mingw
	  OS_TYPE=winnt
	  BUILDINFO="Windows / MinGW"
	  CASE_INSENSITIVE_FS=true
	  ;;
	"MSVC6")
	  OS_VERSION=msvc6
	  OS_TYPE=winnt
	  BUILDINFO="Windows / MS Visual C++\" dmstr2(_MSC_FULL_VER) \""
	  CASE_INSENSITIVE_FS=true
	  ;;
	"Darwin")
	  OS_VERSION=macosx
# MacOSX is not garuanteed to be case insensitive, assume it's case
# sensitive, see issue 73661 for details.
	  ;;
	"AIX")
	  OS_VERSION=sysvr4
	  ;;
	"DragonFly")
	  OS_VERSION=linux
	  ;;
	"FreeBSD")
	  OS_VERSION=linux
	  ;;
	"NetBSD")
	  OS_VERSION=linux
	  ;;
	"IRIX")
	  OS_VERSION=sysvr4
	  ;;
	"IRIX64")
	  OS_VERSION=sysvr4
	  ;;
	"OSF1")
	  OS_VERSION=sysvr4
	  ;;
	"OpenBSD")
	  OS_VERSION=linux
	  ;;
   *)
      AC_MSG_ERROR([$_os operating system is not suitable to build dmake!])
      ;;
esac

AC_MSG_RESULT([checked ($_os)])

dnl Set OS dependent settings
AM_CONDITIONAL(OSTYPEUNIX, test x$OS_TYPE = xunix)
AM_CONDITIONAL(OSTYPEWIN32, test x$OS_TYPE = xwinnt)
AM_CONDITIONAL(MSVC, test x$OS_VERSION =  xmsvc6)

AC_SUBST(OS_TYPE)
AC_SUBST(OS_VERSION)
AC_DEFINE_UNQUOTED(BUILDINFO, "$BUILDINFO", [Build info string])

if test x$CASE_INSENSITIVE_FS = xtrue; then
dnl Mac OSX with HFS+ and Windows FS are case insensitive (although case
dnl preserving).
AC_DEFINE(CASE_INSENSITIVE_FS, 1, [Assume case insensitive file system.])
fi

dnl =============================================
dnl Enable dbug
dnl =============================================
AC_MSG_CHECKING([whether to do a build with dbug macros])
if test -n "$enable_dbug" && test "$enable_dbug" != "no"; then
   DBUG="1"
   CPPFLAGS="$CPPFLAGS -DDBUG=1 -I\$(top_srcdir)/dbug/dbug"
   AC_MSG_RESULT([yes])
else
   DBUG=""
   AC_MSG_RESULT([no])
fi
AM_CONDITIONAL(DBUG, test -n "$DBUG")

dnl =============================================
dnl Enable spawn
dnl =============================================
AC_MSG_CHECKING([if spawn shall be used])
if test -n "$enable_spawn" && test "$enable_spawn" != "no"; then
   AC_DEFINE(ENABLE_SPAWN, 1, [Enables the use of spawn instead of fork/exec if it is supported.])
   AC_MSG_RESULT([yes])
else
   AC_MSG_RESULT([no])
fi

dnl Predefine the DMAKEROOT macro for unix targets.
eval dmakerootprefix="$datarootdir"
# $datadir is ${prefix}/share if not overridden
test "x$dmakerootprefix" != "x${dmakerootprefix##NONE}" && dmakerootprefix=${ac_default_prefix}/share

if test x$OS_TYPE = xunix; then
DMAKEROOT_H_LINE1='"DMAKEROOT := '${dmakerootprefix}'/startup",'
fi
AC_SUBST(DMAKEROOT_H_LINE1)

dnl List (all possible) *.in files
AC_CONFIG_FILES(dmakeroot.h Makefile startup/config.mk \
		startup/Makefile startup/unix/Makefile \
		startup/unix/linux/Makefile startup/unix/solaris/Makefile \
		startup/unix/macosx/Makefile startup/unix/sysvr4/Makefile \
		startup/unix/cygwin/Makefile \
		startup/unix/os2/Makefile \
		startup/winnt/Makefile startup/winnt/mingw/Makefile \
		startup/winnt/msvc6/Makefile \
		tests/Makefile)

dnl Checks for libraries.

dnl Initialize libtool
#AM_PROG_LIBTOOL

dnl Checks for header files.
AC_HEADER_DIRENT
AC_HEADER_STDC
AC_CHECK_HEADERS(fcntl.h limits.h strings.h sys/types.h sys/stat.h unistd.h errno.h utime.h sys/utime.h spawn.h wait.h sys/wait.h sys/time.h cygwin/process.h)

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_TYPE_OFF_T
AC_TYPE_SIZE_T
AC_CHECK_TYPES(int8)
AC_CHECK_TYPES(uint8)
AC_CHECK_TYPES(int16)
AC_CHECK_TYPES(uint16)
AC_CHECK_TYPES(int32)
AC_CHECK_TYPES(uint32)
AC_HEADER_TIME
AC_CHECK_SIZEOF(short, 2)
AC_CHECK_SIZEOF(int, 4)
AC_CHECK_SIZEOF(long, 4)

dnl Checks for library functions.
AC_FUNC_MEMCMP
AC_TYPE_SIGNAL
AC_FUNC_UTIME_NULL
AC_FUNC_VPRINTF
AC_CHECK_FUNCS(getcwd getwd strerror setvbuf tzset settz mkstemp tempnam gettimeofday setenv)
# Useful, but special to newlib/MSVC
AC_CHECK_FUNCS(strlwr)


AC_CACHE_CHECK(whether MSVC utime accepts a null argument, ac_cv_func_msvc_utime_null,
[rm -f conftest.data; >conftest.data
# Sequent interprets utime(file, 0) to mean use start of epoch.  Wrong.
AC_RUN_IFELSE([AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT
	       #ifdef HAVE_SYS_UTIME_H
	       # include <sys/utime.h>
	       #endif
	       #ifdef HAVE_UTIME_H
	       # include <utime.h>
	       #endif],
[[struct stat s, t;
  return ! (stat ("conftest.data", &s) == 0
	    && utime ("conftest.data", 0) == 0
	    && stat ("conftest.data", &t) == 0
	    && t.st_mtime >= s.st_mtime
	    && t.st_mtime - s.st_mtime < 120);]])],
	      ac_cv_func_utime_null=yes,
	      ac_cv_func_utime_null=no,
	      ac_cv_func_utime_null='guessing yes')])
if test "x$ac_cv_func_msvc_utime_null" != xno; then
  ac_cv_func_msvc_utime_null=yes
  AC_DEFINE(HAVE_UTIME_NULL, 1,
	    [Define to 1 if `utime(file, NULL)' sets file's timestamp to the
	     present.])
fi
rm -f conftest.data

#compile script required for all cl.exe from autoconf usage
#IDK why autoconf doesn't add compile script to CXX but it does to CPP
if test "$OS_VERSION" == "msvc6"; then
	CXX="$am_aux_dir/compile $CXX"
fi

dnl *** output to disk ***
AC_OUTPUT

