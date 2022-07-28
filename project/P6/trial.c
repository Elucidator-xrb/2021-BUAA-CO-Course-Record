#include<windows.h>
#include<conio.h>
#include<stdio.h>

int main(){
    SetConsoleCursorInfo( GetStdHandle((DWORD)-14),&(CONSOLE_CURSOR_INFO){1} );
    //SetConsoleCursorPosition(GetStdHandle((DWORD)-11),(COORD){0});
    SetConsoleTextAttribute(GetStdHandle((DWORD)-14),156);
    printf("as\n");
    _cputs(" ");
}