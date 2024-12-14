package;

#if windows
@:buildXml('
<target id="haxe">
	<lib name="dwmapi.lib" if="windows" />
	<lib name="shell32.lib" if="windows" />
	<lib name="gdi32.lib" if="windows" />
	<lib name="ole32.lib" if="windows" />
	<lib name="uxtheme.lib" if="windows" />
</target>
')

// majority is taken from microsofts doc 
@:cppFileCode('
#include "mmdeviceapi.h"
#include "combaseapi.h"
#include <iostream>
#include <Windows.h>
#include <cstdio>
#include <stdlib.h>
#include <stdio.h>
#include <tchar.h>
#include <dwmapi.h>
#include <strsafe.h>
#include <winuser.h>
#include <Shlobj.h>
#include <wingdi.h>
#include <shellapi.h>
#include <uxtheme.h>
#include <string>

#define SAFE_RELEASE(punk)  \\
			  if ((punk) != NULL)  \\
				{ (punk)->Release(); (punk) = NULL; }

static long lastDefId = 0;


#pragma comment(lib, "Shell32.lib")
#pragma comment(lib, "Dwmapi")
')
#end
class WindowsAPI
{
    #if windows
	@:functionCode('
        HWND hWnd = GetActiveWindow();
        res = SetWindowLong(hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) | WS_EX_LAYERED);
        if (res)
        {
            SetLayeredWindowAttributes(hWnd, RGB(1, 1, 1), 0, LWA_COLORKEY);
        }
    ')
    #end
	static public function getWindowsTransparent(res:Int = 0)
	{
		return res;
	}

	#if windows
    @:functionCode('
		int darkMode = enable ? 1 : 0;

		HWND window = GetActiveWindow();
		if (S_OK != DwmSetWindowAttribute(window, 19, &darkMode, sizeof(darkMode))) {
			DwmSetWindowAttribute(window, 20, &darkMode, sizeof(darkMode));
		}
	')
	#end
	public static function setDarkMode(enable:Bool) {}

    #if windows
	@:functionCode('
        HWND hWnd = GetActiveWindow();
        res = SetWindowLong(hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) ^ WS_EX_LAYERED);
        if (res)
        {
            SetLayeredWindowAttributes(hWnd, RGB(1, 1, 1), 1, LWA_COLORKEY);
        }
    ')
    #end
	static public function getWindowsbackward(res:Int = 0)
	{
		return res;
	}

    /**
	 * Sets the console colors
	 */
	 public static function setConsoleColors(foregroundColor:ConsoleColor = NONE, ?backgroundColor:ConsoleColor = NONE) {
		#if (windows && !hl)
		if(foregroundColor == NONE)
			foregroundColor = LIGHTGRAY;
		if(backgroundColor == NONE)
			backgroundColor = BLACK;

		var fg = cast(foregroundColor, Int);
		var bg = cast(backgroundColor, Int);
		setNativeConsoleColors((bg * 16) + fg);
		#else
		#if sys
		Sys.print("\x1b[0m");
		if(foregroundColor != NONE)
			Sys.print("\x1b[" + Std.int(consoleColorToANSI(foregroundColor)) + "m");
		if(backgroundColor != NONE)
			Sys.print("\x1b[" + Std.int(consoleColorToANSI(backgroundColor) + 10) + "m");
		#end
		#end
	}

	#if windows
    @:functionCode('
	if (!AllocConsole())
		return;

	freopen("CONIN$", "r", stdin);
	freopen("CONOUT$", "w", stdout);
	freopen("CONOUT$", "w", stderr);
	')
	#end
	public static function allocConsole() {}

	#if windows
	@:functionCode('
		HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE); 
		SetConsoleTextAttribute(console, color);
	')
	#end
	public static function setNativeConsoleColors(color:Int) {}

	#if windows
	@:functionCode('
		system("CLS");
		std::cout<< "" <<std::flush;
	')
	#end
	public static function clearScreen() {}

	#if windows
	@:functionCode('
		MessageBox(GetActiveWindow(), message, caption, icon | MB_SETFOREGROUND);
	')
	#end
	public static function showMessageBox(caption:String, message:String, icon:MessageBoxIcon = MSG_WARNING) {}

    #if windows
    @:functionCode('
        NOTIFYICONDATA m_NID;

        memset(&m_NID, 0, sizeof(m_NID));
        m_NID.cbSize = sizeof(m_NID);
        m_NID.hWnd = GetForegroundWindow();
        m_NID.uFlags = NIF_MESSAGE | NIIF_WARNING | NIS_HIDDEN;

        m_NID.uVersion = NOTIFYICON_VERSION_4;

        if (!Shell_NotifyIcon(NIM_ADD, &m_NID))
            return FALSE;
    
        Shell_NotifyIcon(NIM_SETVERSION, &m_NID);

        m_NID.uFlags |= NIF_INFO;
        m_NID.uTimeout = 1000;
        m_NID.dwInfoFlags = NULL;

        LPCTSTR lTitle = title.c_str();
        LPCTSTR lDesc = desc.c_str();

        if (StringCchCopy(m_NID.szInfoTitle, sizeof(m_NID.szInfoTitle), lTitle) != S_OK)
            return FALSE;

        if (StringCchCopy(m_NID.szInfo, sizeof(m_NID.szInfo), lDesc) != S_OK)
            return FALSE;

        return Shell_NotifyIcon(NIM_MODIFY, &m_NID);
    ')
    #end

    public static function sendWindowsNotification(title:String = "", desc:String = "", res:Int = 0)
    {
        return res;
    }

	public static function consoleColorToANSI(color:ConsoleColor) {
		return switch(color) {
			case BLACK:			30;
			case DARKBLUE:		34;
			case DARKGREEN:		32;
			case DARKCYAN:		36;
			case DARKRED:		31;
			case DARKMAGENTA:	35;
			case DARKYELLOW:	33;
			case LIGHTGRAY:		37;
			case GRAY:			90;
			case BLUE:			94;
			case GREEN:			92;
			case CYAN:			96;
			case RED:			91;
			case MAGENTA:		95;
			case YELLOW:		93;
			case WHITE | _:		97;
		}
	}
}

enum abstract ConsoleColor(Int) {
	var BLACK = 0;
	var DARKBLUE = 1;
	var DARKGREEN = 2;
	var DARKCYAN = 3;
	var DARKRED = 4;
	var DARKMAGENTA = 5;
	var DARKYELLOW = 6;
	var LIGHTGRAY = 7;
	var GRAY = 8;
	var BLUE = 9;
	var GREEN = 10;
	var CYAN = 11;
	var RED = 12;
	var MAGENTA = 13;
	var YELLOW = 14;
	var WHITE = 15;

	var NONE = -1;
}

enum abstract MessageBoxIcon(Int) {
	//note: these arent colors but the windows hexadecimal code for them
	var MSG_ERROR = 0x00000010;
	var MSG_QUESTION = 0x00000020;
	var MSG_WARNING = 0x00000030;
	var MSG_INFORMATION = 0x00000040;
}
