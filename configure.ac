AC_PREREQ(2.59)
AC_INIT([package build], [1.00], [http://ecliphp.org])

AC_CONFIG_FILES([Makefile.include])
                 
AC_ARG_WITH([arm-toolchain],
  [AS_HELP_STRING([--with-arm-toolchain=],
  [specify path to arm toolchain.])],
  [arm_toolchain=$withval])
  
AC_ARG_WITH([mips-toolchain],
  [AS_HELP_STRING([--with-mips-toolchain=],
  [specify path to mips toolchain.])],
  [mips_toolchain=$withval])
  
AC_ARG_WITH([mipsel-toolchain],
  [AS_HELP_STRING([--with-mipsel-toolchain=],
  [specify path to mipsel toolchain.])],
  [mipsel_toolchain=$withval])

AC_ARG_WITH([install-dir],
  [AS_HELP_STRING([--with-install-dir=],
  [specify path to install package.])],
  [install_dir=$withval])

AC_ARG_WITH([tarballs],
  [AS_HELP_STRING([--with-tarballs=],
  [path where tarballs will be saved.])],
  [use_tarballs=$withval])

AC_ARG_WITH([kernel],
  [AS_HELP_STRING([--with-kernel=],
  [specify path to kernel source.])],
  [kernel_path=$withval])

AC_PATH_PROG(TAR,tar,"no")
if test "x$TAR" = "xno" ; then
  AC_MSG_ERROR("Missing program: tar")
fi

AC_PATH_PROG(GIT,git,"no")
if test "x$GIT" = "xno" ; then
  AC_MSG_ERROR("Missing program: git")
fi

AC_PATH_PROG(CURL,curl,"no")
if test "x$CURL" = "xno" ; then
  AC_MSG_ERROR("Missing program: curl")
fi

AC_PATH_PROG(GZIP,gzip,"no")
if test "x$GZIP" = "xno" ; then
  AC_MSG_ERROR("Missing program: gzip")
fi

AC_PATH_PROG(CMAKE,cmake,"no")
if test "x$CMAKE" = "xno" ; then
  AC_MSG_ERROR("Missing program: cmake")
fi

AC_SUBST(arm_toolchain)
AC_SUBST(mips_toolchain)
AC_SUBST(mipsel_toolchain)
AC_SUBST(install_dir)
AC_SUBST(use_tarballs)
AC_SUBST(kernel_path)
AC_SUBST(TAR)
AC_SUBST(GIT)
AC_SUBST(CURL)
AC_SUBST(GZIP)
AC_SUBST(CMAKE)

AC_OUTPUT
