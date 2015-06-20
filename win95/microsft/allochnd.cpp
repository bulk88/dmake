#ifndef __cplusplus
#   error This must be compiled as C++
#endif

#include <config.h>
/* some mingws dont have new.h, if so, use asm tricks to link to VC C++ funcs
   in msvcrt.dll from plain [GC] C */
#ifdef HAVE_NEW_H
#  include <new.h>
#else
#  include <stddef.h>
#  include <_mingw.h>
#  ifndef _PNH_DEFINED
typedef int (__cdecl *_PNH)(size_t);
#    define _PNH_DEFINED
#  endif

extern "C" __declspec(dllimport) _PNH  __cdecl _set_new_handler(_PNH _NewHandler);
extern "C" __declspec(dllimport) int __cdecl _set_new_mode(int _NewMode);
/* Needed when not static linking the CRT, IE all mingw builds, static CRT build
   uses newmode.obj to provide an initialized global data var with the value
   we need. DLL CRT builds like all mingws need to use a function to set the
   global in the DLL CRT since recompiling and replacing system msvcrt.dll is
   insane */
#  define USE_SET_NEW_MODE
#endif

/* _set_new_* are C++ decorated functions, make an extern C wrapper */

extern "C" void
dm_set_new_handler(_PNH pnh)
{
   _set_new_handler(pnh);
#ifdef USE_SET_NEW_MODE
   _set_new_mode(1);
#endif
}
