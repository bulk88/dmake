/* disabling the jump stubs since they weren't being used due to dllimport
and weren't being optimized out of the binary, IDK why they weren't optimized
out by linker if not used, maybe the "comdat" feature is needed or
_set_new_handler and _set_new_mode should be in different .s/.o files as if
dlltool made them (dlltool stores 1 func per .o in the .a, not 2 like here) */

#ifdef _WIN64
.section .text, "2"
.globl	_set_new_handler
_set_new_handler:
	jmp	*__imp__set_new_handler(%rip)
#else
.section .text
.globl	__set_new_handler
__set_new_handler:
	jmp	*__imp___set_new_handler
#endif

/*.idata$5 is a IMAGE_THUNK_DATA32 or IMAGE_THUNK_DATA64 struct that goes in
  FirstThunk array */
.section .idata$5
#ifdef _WIN64
.globl __imp__set_new_handler
/* some mingws lie that they can link to MSVC C++ code by including new.h with
  mingw. To fix that, include the G++ mangled name along with the plain extern
  "C" name. MS shouldve made these functions extern "C" from day 1 but didnt */
.globl __imp__Z16_set_new_handlerPFiyE
__imp__set_new_handler:
__imp__Z16_set_new_handlerPFiyE:
#else
.globl __imp___set_new_handler
__imp___set_new_handler:
#endif
	.rva	.string_set_new_handler
/* pad to 64 bits because a 64 bit func ptr will be written over the RVA */
#ifdef _WIN64
	.long 0
#endif


#ifdef _WIN64
.section .text, "2"
.globl	_set_new_mode
__set_new_mode:
	jmp	*__imp__set_new_mode(%rip)
#else
	.section .text
.globl	__set_new_mode
__set_new_mode:
	jmp	*__imp___set_new_mode
#endif

.section .idata$7
#ifdef _WIN64
	.rva	 _head_lib64_libmsvcrt_a
#else
	.rva	 __head_libmsvcrt_a
#endif



.section .idata$5
.globl __imp___set_new_mode
__imp___set_new_mode:
/* WIN64 version */
.globl __imp__set_new_mode
.globl __imp__Z13_set_new_modei
__imp__set_new_mode:
__imp__Z13_set_new_modei:
	.rva	.string_set_new_mode
#ifdef _WIN64
	.long 0
#endif


/*.idata$4 is a IMAGE_THUNK_DATA32 or IMAGE_THUNK_DATA64 struct that goes in
  OriginalFirstThunk array */
.section .idata$4
	.rva	.string_set_new_handler
#ifdef _WIN64
	.long 0
#endif

.section .idata$4
	.rva	.string_set_new_mode
#ifdef _WIN64
	.long 0
#endif

/*1=aligned to 2 bytes, old gases dont have this and therefore
  warn "Warning: unknown section attribute '1'"
  this is a struct _IMAGE_IMPORT_BY_NAME */
.section .idata$6, "1"
.string_set_new_handler:
	.short	0
#ifdef _WIN64
	.ascii	"?_set_new_handler@@YAP6AH_K@ZP6AH0@Z@Z\000"
#else
	.ascii	"?_set_new_handler@@YAP6AHI@ZP6AHI@Z@Z\000"
#endif

/* 1=aligned to 2 bytes */
.section .idata$6, "1"
.string_set_new_mode:
	.short	0
	.ascii	"?_set_new_mode@@YAHH@Z\000"
