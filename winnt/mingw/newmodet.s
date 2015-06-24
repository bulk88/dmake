	.section	.idata$4
	.long	0
#ifdef _WIN64
	.long	0
#endif
	.section	.idata$5
	.long	0
#ifdef _WIN64
	.long	0
#endif
	.section	.idata$7
/*on some mingws this symbol is called __libmsvcrt_a_iname , on others it is
  __lib64_libmsvcrt_a_iname , the reason for this is that dlltool was called
  like "dlltool -d msvcrt.def -l lib64/libmsvcrt.a" when the .a was created and
  dlltool embeded the output path into the symbol

  If this lib was created with dlltool there would be a separate newmodeh.S
  which causes a 2nd or 3rd IMAGE_IMPORT_DESCRIPTOR struct for msvcrt.dll to
  exist (3rd = libmsvcrt.a+libmoldname.a+dlltool made dmake c++ imports). By
  not making a 3rd IMAGE_IMPORT_DESCRIPTOR for msvcrt.dll and reusing the one
  from libmsvcrt.a some space in dmake.exe is saved.
  */
#ifdef _WIN64
	.global	__lib64_libmsvcrt_a_iname
__lib64_libmsvcrt_a_iname:	.asciz	"msvcrt.dll"
#else
	.global	__libmsvcrt_a_iname
__libmsvcrt_a_iname:	.asciz	"msvcrt.dll"
#endif
