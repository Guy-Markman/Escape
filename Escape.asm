;A huge thanks to Alon Bar-Lev and Sarit Lolav to teaching me almost everything I know about programming
ideal
p8086
model small
stack 100h
segment textseg at 0b800h
	text db 80*24*2 dup(?) ;The memory of the graphic card for text mode
ends
dataseg
startdata	db 1,1,2,0,0,0,0 ;Data that will be used if the player will restart the game
;
;The location of the player
;
X	db	1 ;The location in the Quarter in his X axis 
Y	db	1 ;The location in the Quarter in his Y axis 
Q	db	2 ;What quarter the player is in right now

HitingWall	db		0 ;Does the sound when the player is hitting a wall is on or off. 0 off, 1 on
MovingSound	db		0 ;Does the sound when the player is moving is on or off. 0 off, 1 on
NumberMoves	dw		0 ;The number of moves the player done
;
;Information about bits type
;
wall	db	219d,039h
road	db	32d,03Ah
player	db	02h,03Ah
;' ',03Ah= road
;219d,039h=wall
;02h,03Ah=player
;How the first Screen is
UL		db	80 dup(219d,039h)	;first line
		db	219d,039h,' ',03Ah,27 dup(219d,039h),16 dup(' ',03Ah),35 dup (219d,039h); second line
		db	2 dup (219d,039h,' ',03Ah,40 dup(219d,039h),' ',03Ah,37 dup (219d,039h)); third&forth line
		db	219d,039h, 7 dup(' ',03Ah),10 dup(219d,039h),40 dup (' ',03Ah),10 dup(219d,039h),12 dup(' ',03Ah); fifth line
		db	219d,039h, ' ',03Ah, 5 dup(219d,039h),12 dup (' ',03Ah),10 dup(219d,039h),' ',03Ah,12 dup(219d,039h),' ',03Ah,14 dup(219d,039h),12 dup (' ',03Ah),11 dup (219d,039h); sixth line
		db 	219d,039h, ' ',03Ah,10 dup (219d,039h),' ',03Ah,16 dup(219d,039h),10 dup (' ',03Ah),3 dup (219d,039h),' ',03Ah,25 dup(219d,039h),12 dup (' ',03Ah);seventh line
		db	219d,039h, ' ',03Ah,5 dup(219d,039h),6 dup(' ',03Ah), 16 dup(219d,039h),' ',03Ah,8 dup (219d,039h),' ',03Ah,3 dup (219d,039h), 17 dup (' ',03Ah), 21 dup (219d,039h); eighth line
		db	219d,039h, ' ',03Ah,5 dup(219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,16 dup (219d,039h), 2 dup (' ',03Ah),17 dup (219d,039h),' ',03Ah, 31 dup (219d,039h); ninth line
		db	219d,039h, ' ',03Ah,5 dup(219d,039h),2 dup (' ',03Ah), 3 dup (219d,039h),11 dup (' ',03Ah),7 dup (219d,039h),' ',03Ah,7 dup (219d,039h),42 dup (' ',03Ah); tenth line
		db	219d,039h, ' ',03Ah,6 dup(219d,039h),' ',03Ah,3 dup (219d,039h),' ',03Ah, 17 dup (219d,039h),2 dup (' ',03Ah),6 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,31 dup (219d,039h)	;eleventh line
		db	219d,039h, ' ',03Ah,6 dup(219d,039h),' ',03Ah,3 dup (219d,039h),' ',03Ah, 18 dup (219d,039h),' ',03Ah,6 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,31 dup (219d,039h)	;twelfth line
		db	219d,039h, ' ',03Ah,6 dup(219d,039h),' ',03Ah,3 dup (219d,039h),' ',03Ah, 18 dup (219d,039h),2 dup (' ',03Ah),5 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,4 dup (219d,039h),32 dup (' ',03Ah);thirteenth  line
		db	219d,039h, ' ',03Ah,6 dup(219d,039h), 2 dup (' ',03Ah),2 dup (219d,039h),' ',03Ah, 19 dup (219d,039h),' ',03Ah,5 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,9 dup (219d,039h),' ',03Ah,17 dup (219d,039h),' ',03Ah, 8 dup (219d,039h)		; fourteenth line
		db	219d,039h, ' ',03Ah,7 dup(219d,039h), ' ',03Ah,2 dup (219d,039h),' ',03Ah, 19 dup (219d,039h),2 dup(' ',03Ah),4 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,9 dup (219d,039h),' ',03Ah,17 dup (219d,039h),' ',03Ah,8 dup (219d,039h)	; fifteenth line
		db	219d,039h, ' ',03Ah,7 dup(219d,039h),2 dup (' ',03Ah),219d,039h, 22 dup (' ',03Ah),4 dup (219d,039h),' ',03Ah,14 dup (219d,039h),4 dup (' ',03Ah),12 dup (219d,039h),3 dup (' ',03Ah),8 dup (219d,039h); sixteenth line
		db 	219d,039h, ' ',03Ah,8 dup(219d,039h), ' ',03Ah, 5 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,16 dup (219d,039h),' ',03Ah,13 dup (219d,039h), 2 dup (' ',03Ah), 2 dup (219d,039h),' ',03Ah,10 dup (219d,039h), 3 dup (' ',03Ah), 219d,039h, 9 dup (' ',03Ah)								; seventeenth line
		db	219d,039h, ' ',03Ah,8 dup(219d,039h), 2 dup (' ',03Ah), 4 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah,15 dup (219d,039h), 2 dup (' ',03Ah),13 dup (219d,039h), ' ',03Ah,3 dup (219d,039h),14 dup (' ',03Ah), 4 dup (219d,039h),' ',03Ah, 5 dup (219d,039h)									; eighteenth line 
		db	219d,039h, 9 dup (' ',03Ah),219d,039h,' ',03Ah,4 dup (219d,039h),' ',03Ah,4 dup (219d,039h), 32 dup (' ',03Ah),10 dup (219d,039h),' ',03Ah,10 dup (219d,039h),' ',03Ah,5 dup (219d,039h)																														; nineteenth line
		db	219d,039h, ' ',03Ah, 2 dup(219d,039h),' ',03Ah,  4 dup (219d,039h),' ',03Ah,219d,039h, ' ',03Ah, 4 dup (219d,039h),' ',03Ah,4 dup (219d,039h), ' ',03Ah, 22 dup (219d,039h),' ',03Ah,7 dup (219d,039h),2 dup (' ',03Ah,10 dup (219d,039h)),' ',03Ah, 5 dup (219d,039h)											; twenty line		
		db	219d,039h, ' ',03Ah, 2 dup(219d,039h),' ',03Ah,  4 dup (219d,039h),' ',03Ah,219d,039h, ' ',03Ah, 4 dup (219d,039h),' ',03Ah,4 dup (219d,039h), ' ',03Ah, 219d,039h, 22 dup (' ',03Ah),7 dup (219d,039h),' ',03Ah,10 dup (219d,039h),' ',03Ah,16 dup (219d,039h)													;twenty first century breakdown
		db	219d,039h, 2 dup (' ',03Ah, 2 dup(219d,039h)), 3 dup (' ',03Ah),219d,039h,11 dup (' ',03Ah),219d,039h,' ',03Ah, 20 dup (219d,039h),' ',03Ah, 7 dup (219d,039h),' ',03Ah,10 dup (219d,039h),' ',03Ah,16 dup (219d,039h)																							; twenty second line
		db	219d,039h,' ',03Ah, 2 dup (2 dup(219d,039h),' ',03Ah), 2 dup (219d,039h,' ',03Ah),2 dup (4 dup (219d,039h),' ',03Ah),219d,039h,57 dup (' ',03Ah)																																								; twenty third line
		db	2 dup (219d,039h,' ',03Ah, 2 dup (2 dup(219d,039h),' ',03Ah), 2 dup (219d,039h,' ',03Ah),2 dup (4 dup (219d,039h),' ',03Ah),219d,039h,' ',03Ah, 20 dup (219d,039h),' ',03Ah, 7 dup (219d,039h),' ',03Ah,5 dup (219d,039h),' ',03Ah,4 dup (219d,039h),' ',03Ah, 8 dup (219d,039h),' ',03Ah, 7 dup (219d,039h))	; twenty third and the twenty forth line
UR		db	'UR.txt',0	;The name of the text document that the information of UR is in it	
DLow	db	'DL.txt',0	;The name of the text document that the information of DL is in it	
DR		db	'DR.txt',0	;The name of the text document that the information of DR is in it	
Open	db	'Open.txt',0	;The name of the text document that the information of Open is in it	
MSG		db	82*25+3 dup (?)	;The size of the memory position when the information of the Screens will be saved
PressAnyKeyMSG	db	'Press any Key to start'
endPress=$
Instractor	db	'W/ Up Arrow to move Up     '
endI=$
InstractorA	db 'A/ Left Arrow to move left '
endA=$
InstractorS	db	'S/Down Arrow to move down  '
endIS=$
InstractorD	db	'D/Right Arrow to move Right'
endD=$
StartMSG	db	'Start'
endStartMSG=$
RulesMSG	db	'Rules'
endRules=$
WinMSG1	db	'You Won!',0dh, 0ah, 'You moved ','$' ;The winning message part 1
WinMsg2	db	' times.', 0dh, 0ah, 'Press Esc to Exit or Enter to restart the game.','$' ;The winning message part 2
MovesHelper	db	?,?,?,?,?,'$' ;The digits when we change the number of move from Hex base to Dec Base will be saved over here
;Music and sound
Wallnote	dw	12580D
Movenote	dw	10847D
musicplayed	db	0 ;Is any music is played right now
sec		db	?	;The ending second will be saved over here
mil		db	?	;The ending milliseconds will be saved over here
codeseg
Initielize:	
	mov 	ax, @data
    mov 	ds, ax
	
	;
	;Change cursor position to row 25
	;
	mov	DH,25
	mov	DL,25
	call	cleanset
	;
	;make segment textseg usable
	;	
	mov ax, textseg
	mov es, ax
	assume es:textseg

;
;Open the start and all its things
;
OpenScreen: ;Show us the opening screen
	lea	dx,[Open]	
	call	ChangeScreen ;Will open and screen the screen in Open.txt
	mov ax, textseg
	mov es, ax
	assume es:textseg ;Making textseg usable
	
	;Print the word 'Rules', In (13,19)
	xor ax,ax 
	mov al,19
	push ax ;Y size
	mov al,13
	push ax ;X size
	call calculate_Location 
	mov bx,ax
	mov si, offset RulesMSG
	mov cx, offset endRules-offset RulesMSG
	call	PrintToScreen
	
	;Print the word 'Start', (63,19)
	xor ax,ax 
	mov al,19 ;Y size
	push ax
	mov al,63 ;X size
	push ax
	call calculate_Location
	mov bx,ax
	mov si, offset StartMSG
	mov cx, offset endStartMSG-offset StartMSG
	call	PrintToScreen
	
RulesStart:
;Print a rectangle around rules, his left upper corner is in (10, 17)
	xor ax,ax
	mov al,17 ;Y size
	push ax
	mov al,10 ;X size
	push ax
	call calculate_Location
	push ax
	call DrawRectangle
AroundLoop:
	xor 	ah, ah  ; wait for key and read
    int 	16h 	; bios keyboard
	cmp ah, 4Dh	;Right Key
	JNE	NotStartRight
;
; Delete the rectangle that his left upper corner is in (10, 17)
;
	xor ax,ax
	mov al,17
	push ax
	mov al,10
	push ax
	call calculate_Location
	push ax
	call DeleteRectangle
	JMP AroundStart
NotStartRight:	
	CMP ah,	1Ch ;Enter
	JE RulesScreen
	JMP AroundLoop
	
	
AroundStart:
	;Print a rectangle around rules
	xor ax,ax
	mov al,17
	push ax
	mov al,60
	push ax
	call calculate_Location
	push ax
	call DrawRectangle
StartLoop:
	xor 	ah, ah  ; wait for key and read
    int 	16h 	; bios keyboard
	cmp ah, 4Bh	;Left Arrow
	JNE	NotStartLeft
	;If you press Left Arrow, you delete the the rectangle first and then move
	xor ax,ax
	mov al,17
	push ax
	mov al,60
	push ax
	call calculate_Location
	push ax
	call DeleteRectangle
	JMP RulesStart
NotStartLeft:	
	CMP ah,	1Ch ;Enter
	JE	move
	JMP StartLoop
	
RulesScreen:
	mov cx,80*24
	xor bx,bx
RulesLoop:
	mov [text+bx],219d
	mov [text+bx+1],039h
	add bx,2
	loop	RulesLoop
	;print "Rules"
	xor ax,ax
	mov al, 4
	push ax
	mov al,37
	push ax
	call calculate_Location
	mov bx,ax
	mov bx,ax
	mov si, offset RulesMSG
	mov cx, offset endRules-offset RulesMSG
	call	PrintToScreen	
	xor ax,ax
	mov al,6
	push ax
	mov al,27
	push ax
	call calculate_Location
	mov bx,ax	
;Print Instractor
	mov si, offset Instractor
	mov cx, offset endI-offset Instractor
	call PrintToScreen
	add bx,160
;Print InstractorA
	mov si, offset InstractorA
	mov cx, offset endA-offset InstractorA
	call PrintToScreen
	add bx,160
;Print InstractorS
	mov si, offset InstractorS
	mov cx, offset endIS	- offset InstractorS
	call PrintToScreen
	add bx,160
;Print InstractorD
	mov si, offset InstractorD
	mov cx, offset endD	- offset InstractorD
	call PrintToScreen
	add bx,320
;Print PressAnyKeyMSG
	mov si, offset PressAnyKeyMSG
	mov cx, offset endPress	- offset PressAnyKeyMSG
	call PrintToScreen
	xor 	ah, ah  ; wait for key and read
    int 	16h 	; bios keyboard
	
	
;
;move the the data from UL (the first screen we see) to textseg so we will be able to see it
;
move:	
	mov al,[byte UL+bx]
	mov	[byte ptr text+bx],al
	inc bx
	loop move
	mov [text+162],02h
	mov [text+163],03Ah
AfterIn:
;
;Check if there is a need to stop sound
;	
	CMP	[musicplayed],1
	JNE nomusic
;
;Get system time
;
	mov ah,2ch
	int 21h
	CMP	[sec],dh
	JA	nomusic
	CMP	[mil],dl
	JA	nomusic
; close the speaker
closespeaker:
	in al, 61h 
	and al, 11111100b 
	out 61h, al
	mov [musicplayed],0
	mov [HitingWall],0
	mov [MovingSound],0
nomusic:
   	mov 	ah, 1   ; get keystroke status
    int 	16h 	; bios keyboard
    jz  	AfterIn  ; has key?
	
	;
    ; ah - scan code
	;
;
;if Up arrow is pressed
;
	cmp ah, 48h
	jne notUp
UpArrow:
	xor ax,ax
	mov	al,[Y]
	dec	al
	push ax
	xor al,al
	mov	al,[X]
	push ax
	call	calculate_Location
	mov	bx,ax
	call	checkmovment
	cmp	ax,0
	jne	MovUp	
	CMP	[HitingWall], al;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE UpGoBack;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,75d ; for 50 milliseconds
	xor ah,ah
	push ax
	mov ax,[Wallnote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [HitingWall],1;To show that the sound where you hit the wall happens
UpGoBack:
	JMP GoBack
MovUp:
	inc [NumberMoves]
	call Up;moving the player one pixel Up and update his location info
	mov	al,[Y]
	dec al
	mov	[Y],al
	CMP	[MovingSound], 0;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE ChangeUp;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,10d ; for 10 milliseconds
	xor ah,ah
	push ax
	mov ax,[Movenote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [MovingSound],1
ChangeUp:
	jmp Change
notUp:

;
;if W is pressed
;
	cmp ah,11h
	je	UpArrow

;
;if Left arrow is pressed
;
	
	cmp ah, 4Bh
	jne notLeft	
LeftKey:
	xor ax,ax
	mov	al,[Y]
	push ax
	xor al,al
	mov	al,[X]
	dec	al
	push ax
	call	calculate_Location
	mov	bx,ax
	call	checkmovment
	cmp	ax,0
	jne	movleft
	CMP	[HitingWall], al;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE LeftGoBack;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,75d ; for 50 milliseconds
	xor ah,ah
	push ax
	mov ax,[Wallnote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [HitingWall],1;To show that the sound where you hit the wall happens
LeftGoBack:
	JMP GoBack
movleft:
	inc [NumberMoves]
	call Left;moving the player one pixel Left and update his location info
	mov	al,[X]
	dec al
	mov	[X],al
	CMP	[MovingSound], 0;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE ChangeLeft;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,10d ; for 10 milliseconds
	xor ah,ah
	push ax
	mov ax,[Movenote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [MovingSound],1
ChangeLeft:
	jmp Change
notLeft:

;
;	if A is pressed
;
	cmp	ah,1Eh
	je LeftKey
	
	
	;
	;if down arrow is pressed
	;
	cmp ah, 50h
	jne notDown
Downarrow:
	xor ax,ax
	mov	al,[Y]
	inc	al
	push ax
	xor al,al
	mov	al,[X]
	push ax
	call	calculate_Location
	mov	bx,ax
	call	checkmovment
	cmp	ax,0
	jne	movdown
	CMP	[HitingWall], al;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE DownGoBack;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,75d ; for 50 milliseconds
	xor ah,ah
	push ax
	mov ax,[Wallnote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [HitingWall],1;To show that the sound where you hit the wall happens
DownGoBack:
	JMP GoBack
movdown:;moving the player one pixel down and update his location info
	inc [NumberMoves]
	call Down
	mov	al,[Y]
	inc al
	mov	[Y],al
	CMP	[MovingSound], 0;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE ChangeDown;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,10d ; for 10 milliseconds
	xor ah,ah
	push ax
	mov ax,[Movenote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [MovingSound],1
ChangeDown:
	jmp Change
notDown:
;
;	if S is pressed
;
	cmp	ah,1Fh
	je Downarrow
;
;if Right arrow is pressed
;
	
	cmp ah, 4Dh
	jne notRight	
RightKey:
	xor ax,ax
	mov	al,[Y]
	push ax
	xor al,al
	mov	al,[X]
	inc	al
	push ax
	call	calculate_Location
	mov	bx,ax
	call	checkmovment
	cmp	ax,0
	jne	movRight
	CMP	[HitingWall], al;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE RightGoBack ;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,75d; for 75 milliseconds
	xor ah,ah
	push ax
	mov ax,[Wallnote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [HitingWall],1 ;To show that the sound where you hit the wall happens
RightGoBack:
	JMP GoBack
movRight:
	inc [NumberMoves]
;moving the player one pixel right and update his location info
	call Right
	mov	al,[X]
	inc al
	mov	[X],al
	CMP	[MovingSound], 0;if hittingwall equal 0, the voice when you hit the wall is not happening
	JNE ChangeRight;putting the parameters of TurnOnMusic (the function where you turn any music on)	
	mov al,10d ; for 10 milliseconds
	xor ah,ah
	push ax
	mov ax,[Movenote]
	push ax
	lea ax,[mil]
	push ax
	lea ax,[sec]
	push ax
	call TurnOnMusic
	mov [MovingSound],1
ChangeRight:
	jmp Change
notRight:
;
;If D is pressed
;
	cmp ah,20h
	je RightKey
	
esckey:	
	;		
    ;if esc pressed, exit
	;
	cmp ah,01
	jne Change
	exit:
;
; resetting es so we can use it in the future
;	
	assume es:nothing
	push ds
	pop es
	; close the speaker
	in al, 61h 
	and al, 11111100b 
	out 61h, al
;
; move the cursor to the left right corenr of the screen	
;
	mov DH,0
	mov	DL,0
	call cleanset
;
;get page number
;
	mov ah,0fh
	int 10h
;
;exit using dos
;
    mov 	al,0
    mov 	ah, 04ch
    int 	21h
;
;This case the player reach to the end of the screen and change it
;
Change:	
ChangeofQ2:
	CMP	[Q],2
	JNE ChangeofQ1
ULtoUR:
	CMP	[X],79d
	JNE	ULtoDL
	lea	dx,[UR]
	call	ChangeScreen
	xor ax,ax
	mov al,[Y]
	push ax
	mov [Q],1
	sub [X],79d
	xor ax,ax
	mov al,[X]
	push ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	jmp NoChagne
ULtoDL:
	CMP[Y],24d
	JNE ChangeofQ1
	lea	dx,[DLow]
	call	ChangeScreen
	xor ax,ax
	mov	[Q],3
	mov [Y],0
	mov	al,[Y]
	push	ax
	xor ax,ax
	mov al,[X]
	push	ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	jmp NoChagne
	
	
	
ChangeofQ1:
	CMP	[Q],1
	JE SkipQ1
	JMP	ChangeofQ3
SkipQ1:
	CMP	[X],0d
	JNE	URtoDR
URtoUL:
	mov	[Q],2
	add [X],79d
	mov cx, 4000d ; the size of textseg is 4000d
	mov ax, textseg
	mov es, ax
	assume es:textseg
	xor bx,bx
;
;move the the data from UL (the first screen we see) to textseg so we will be able to see it
;
moveUL:	
	mov al,[byte UL+bx]
	mov	[byte ptr text+bx],al
	inc bx
	loop moveUL
	xor ax,ax
	mov al,[Y]
	push ax
	xor ax,ax
	mov [X],79d
	mov al,[X]
	push ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	jmp NoChagne
	
URtoDR:
	CMP[Y],24d
	JNE ChangeofQ3
	lea	dx,[DR]
	call	ChangeScreen
	xor ax,ax
	mov	[Q],4
	mov [Y],0
	mov	al,[Y]
	push	ax
	xor ax,ax
	add [X],1
	mov al,[X]
	push	ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	xor ax,ax
	mov al,24
	push ax
	mov al,77d
	push ax
	call calculate_Location
	mov bx,ax
	;
	;Marking the pixels around the door with red 
	;
	mov [text+bx+1],044h
	mov [text+bx+5],044h
	jmp NoChagne
	
ChangeofQ3:
	cmp	[Q],3
	JE	Skip
	JMP	ChangeofQ4
Skip:
DLowtoUL:
	CMP	[Y],0
	JNE DLtoDR
	mov	[Q],2
	mov [Y],24d
	mov cx, 4000d ; the size of textseg is 4000d
	mov ax, textseg
	mov es, ax
	assume es:textseg
	xor bx,bx
;move the the data from UL (the first screen we see) to textseg so we will be able to see it
loopDLowtoUL:	
	mov al,[byte UL+bx]
	mov	[byte ptr text+bx],al
	inc bx
	loop loopDLowtoUL
	xor ax,ax
	mov [Y],24d
	mov al,[Y]
	push ax
	xor ax,ax
	mov al,[X]
	push ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	jmp NoChagne
DLtoDR:
	CMP	[X],79d
	JNE ChangeofQ4
	lea	dx,[DR]
	call	ChangeScreen
	xor ax,ax
	mov	[Q],4
	mov [X],0
	mov	al,[Y]
	push	ax
	xor ax,ax
	mov al,[X]
	push	ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	xor ax,ax
	mov al,24
	push ax
	mov al,77d
	push ax
	call calculate_Location
	mov bx,ax
	mov [text+bx+1],044h
	mov [text+bx+5],044h
	jmp NoChagne	
ChangeofQ4:
	CMP	[Q],4
	JNE	NoChagne
	CMP	[Y],0d
	JNE	DRtoDL
DRtoUR:
	mov [Q],1
	mov [Y],24d
	lea	dx,[UR]
	call ChangeScreen
	xor ax,ax
	mov al,[Y]
	push ax
	sub	[X],1
	xor ax,ax
	mov al,[X]
	push ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	jmp NoChagne
DRtoDL:
;Switch the screen from Down Right to Down left
	CMP	[X],0
	JNE	NoChagne
	mov [Q],3
	mov [X],79d
	lea	dx,[DLow]
	call ChangeScreen
	xor ax,ax
	mov al,[Y]
	push ax
	xor ax,ax
	mov al,[X]
	push ax
	call calculate_Location
	mov bx,ax
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov	al,02h
	mov	[text+bx],al
	mov	al,03Ah
	mov	[text+bx+1],al
	jmp NoChagne
	
NoChagne:
;	Check if you win
	CMP	[Q],4d
	JE	SkipNochange1
	JMP GoBack
SkipNochange1:
	CMP	[X],78d
	JE	SkipNochange2
	JMP GoBack
SkipNochange2:	
	CMP	[Y],25d
	JE	SkipNochange3
	JMP GoBack
SkipNochange3:
	mov	DH,0
	mov	DL,0
	call	cleanset
	Lea	dx, [WinMSG1]
	mov	ah, 9
	int	21h
;
;Change the number in [NumberMoves] to Decimally
;
	mov ax,[NumberMoves]
	mov di,10d
	lea si,[MovesHelper+5]
ChangeMoves:
	dec si
	xor dx,dx
	div di	
	mov bx,dx
	add bl,'0'
	mov [si],bl
	cmp si,offset MovesHelper
	jne ChangeMoves	
	xor bx, bx
Remove0Loop:
	CMP [MovesHelper+bx],'0'
	JNE	PrintMoveHelper
	inc bx
	JMP Remove0Loop
PrintMoveHelper:
	lea dx, [MovesHelper+bx]
	mov	ah, 9
	int	21h
	Lea	dx, [WinMSG2]
	mov	ah, 9
	int	21h	
	
; open speaker
	in al, 61h 
	or al, 00000011b 
	out 61h, al 
; send control word to change frequency
	mov al, 0B6h
	out 43h, al
; play frequency 
	mov ax, 2711
	out 42h, al ; Sending lower byte 
	mov al, ah
	out 42h, al ; Sending upper byte
	mov ah,2ch
	int 21h
	mov [sec],dh
	mov [mil],dl
	add [mil],22
	CMP [mil],100
	JNA	SkipMusicwin1
	sub [mil],100
	inc [sec]
SkipMusicwin1:
	mov ah,2ch
	int 21h
	CMP	[sec],dh
	JA	SkipMusicwin1
	CMP	[mil],dl
	JA	SkipMusicwin1

;
;Winning music
;A huge thanks to Yaheli Yahiri in teaching me how music work
;
	
; send control word to change frequency
	mov al, 0B6h
	out 43h, al
; play frequency 
	mov ax, 2560
	out 42h, al ; Sending lower byte 
	mov al, ah
	out 42h, al ; Sending upper byte
	mov ah,2ch
	int 21h
	mov [sec],dh
	mov [mil],dl
	add [mil],22
	CMP [mil],100
	JNA	SkipMusicwin2
	sub [mil],100
	inc [sec]
SkipMusicwin2:
	mov ah,2ch
	int 21h
	CMP	[sec],dh
	JA	SkipMusicwin2
	CMP	[mil],dl
	JA	SkipMusicwin2
	
; send control word to change frequency
	mov al, 0B6h
	out 43h, al
; play frequency 
	mov ax, 2415
	out 42h, al ; Sending lower byte 
	mov al, ah
	out 42h, al ; Sending upper byte
	mov ah,2ch
	int 21h
	mov [sec],dh
	mov [mil],dl
	add [mil],22
	CMP [mil],100
	JNA	SkipMusicwin3
	sub [mil],100
	inc [sec]
SkipMusicwin3:
	mov ah,2ch
	int 21h
	CMP	[sec],dh
	JA	SkipMusicwin3
	CMP	[mil],dl
	JA	SkipMusicwin3
	
; send control word to change frequency
	mov al, 0B6h
	out 43h, al
; play frequency 
	mov ax, 2281
	out 42h, al ; Sending lower byte 
	mov al, ah
	out 42h, al ; Sending upper byte
	mov ah,2ch
	int 21h
	mov [sec],dh
	mov [mil],dl
	add [mil],12
	add [sec],1
	CMP [mil],100
	JNA	SkipMusicwin4
	sub [mil],100
	inc [sec]
SkipMusicwin4:
	mov ah,2ch
	int 21h
	CMP	[sec],dh
	JA	SkipMusicwin4
	CMP	[mil],dl
	JA	SkipMusicwin4
; close the speaker
	in al, 61h 
	and al, 11111100b 
	out 61h, al
		
WinLoop:
	xor 	ah, ah  ; wait for key and read
    int 	16h 	; bios keyboard
	cmp AH,1 ;ESC
	JNE	SkipWinLoop
	JMP Exit
SkipWinLoop:
	CMP	AH,1CH ;Enter
	JNE WinLoop
	mov cx,7
	xor bx,bx
Loopint:
	mov al,[startdata+bx]
	mov [X+bx],al
	inc bx
	loop Loopint
	JMP Initielize
	
	
GoBack:
;Go Back
	xor 	ah, ah  ; wait for key and read
    int 	16h 	; bios keyboard
	JMP AfterIn
proc cleanset
;
;Clean the screen
;
mov ah, 0fh ; function - get video mode
int 10h
mov ah, 0 ; function - set video mode
int 10h
mov ah, 3 ; function - set video mode
int 10h

mov	Ah,02h ;Set Cursor Position
int	10h
ret
endp	cleanset

proc	calculate_Location
	
;
;Calculate the location on the textseg of the data we give
;Cartiage:
;	Y size
;	X size
;
;Return:
;	ax=location on textseg
;

arg	SX:word,	\
	SY:word		\
	=prm_size
	
;
; entry sequence
;
	push	bp
	mov	bp,sp
;
; save registers
;
	push	cx
	
	xor ax,ax
	xor cx,cx
	mov	cx,	[SY]
@@loop1:
	add ax,80d
	loop	@@loop1
	add	ax, [SX]
	add	ax, ax
	
;
;	Restore sequence
;
	pop	cx

;
; leave sequence
;

	mov 	sp, bp
    pop 	bp
    ret 	prm_size
endp
;
;Down - player goes one Pixel down
;
;Entry:
;	BX=location wanted on textseg
;	
;
;Return:
;	none
;


codeseg
;
;Left - player goes one Pixel to the Left
;
;Entry:
;	BX=location wanted on textseg
;	SI=What kind of movement it is
;
;Return:
;	none
;
codeseg
proc 	Left
;
;make segment textseg usable
;
	mov ax, textseg
	mov es, ax
	assume es:textseg
;
;	Put the bytes of player in the pixel under the player currect position
;
	mov	al,[byte ptr player]
	mov	[text+bx],al
	mov	al,[byte ptr player+1]
	mov	[text+bx+1],al
;
;	Put the bytes of road in the pixel where the player was
;
	mov	al,[byte ptr Road]
	mov	[text+bx+2],al
	mov	al,[byte ptr Road+1]
	mov	[text+bx+2+1],al
;
; resetting es so we can use it in the future
;
	assume es:nothing
	push ds
	pop es
	ret
endp	Left
proc 	Down
;
;make segment textseg usable
;
	mov ax, textseg
	mov es, ax
	assume es:textseg
;
;	Put the bytes of player in the pixel under the player currect position
;
	mov	al,[byte ptr player]
	mov	[text+bx],al
	mov	al,[byte ptr player+1]
	mov	[text+bx+1],al
;
;	Put the bytes of road in the pixel where the player was
;
	mov	al,[byte ptr Road]
	mov	[text+bx-160],al
	mov	al,[byte ptr Road+1]
	mov	[text+bx-160+1],al
;
; resetting es so we can use it in the future
;
	assume es:nothing
	push ds
	pop es
	ret
endp	Down
;
;Right - player goes one Pixel to the right
;
;Entry:
;	BX=location wanted on textseg
;	SI=What kind of movement it is
;
;Return:
;	none
;
codeseg
proc 	Right
;
;make segment textseg usable
;
	mov ax, textseg
	mov es, ax
	assume es:textseg
;
;	Put the bytes of player in the pixel under the player currect position
;
	mov	al,[byte ptr player]
	mov	[text+bx],al
	mov	al,[byte ptr player+1]
	mov	[text+bx+1],al
;
;	Put the bytes of road in the pixel where the player was
;
	mov	al,[byte ptr Road]
	mov	[text+bx-2],al
	mov	al,[byte ptr Road+1]
	mov	[text+bx-2+1],al
;
; resetting es so we can use it in the future
;
	assume es:nothing
	push ds
	pop es
	ret
endp	Right
;
;UP - player goes one Pixel Upward
;
;Entry:
;	BX=location wanted on textseg
;	SI=What kind of movement it is
;
;Return:
;	none
;
codeseg
proc 	Up
;
;make segment textseg usable
;
	mov ax, textseg
	mov es, ax
	assume es:textseg
;
;	Put the bytes of player in the pixel under the player currect position
;
	mov	al,[byte ptr player]
	mov	[text+bx],al
	mov	al,[byte ptr player+1]
	mov	[text+bx+1],al
;
;	Put the bytes of road in the pixel where the player was
;
	mov	al,[byte ptr Road]
	mov	[text+bx+160],al
	mov	al,[byte ptr Road+1]
	mov	[text+bx+160+1],al
;
; resetting es so we can use it in the future
;
	assume es:nothing
	push ds
	pop es
	ret
endp	Up
;
;	checkmovment-	check if movement is possible by comparing the bit we are going to to a wall
;					work only for right and down 
;	Entry:
;	BX-location on textseg
;	Return:
;	AX-	0	can't move
;		1	can move
;
proc	checkmovment
;
;make segment textseg usable
;
	mov ax, textseg
	mov es, ax
	assume es:textseg
;
;	Compare the text to a wall
;
	xor	ax,ax
	mov	al,[wall]
	cmp	[text+bx],al
	jne	@@passable
	xor	ax,ax
	assume es:nothing
	push ds
	pop es
	ret
@@passable:
	mov	ax,1
	ret
endp	checkmovment
;
;ChangeScreen- The proc change the screen to the screen we need to
;
proc	ChangeScreen
codeseg
	push	ax
	push	bx
	push	cx
	push	si
	
	mov	al,2
;
;	Open and read the file and copy it to MSG
;
	call	OpenFile
	mov	bx,ax
	mov	cx,2*82*25
	lea	dx,[MSG]
	call	ReadFile
	call	CloseFile
	
;
;	Copy the contect of MSG to the textseg
;
	mov ax, textseg
	mov es, ax
	assume es:textseg

	mov	cx,2500d
	XOR	BX,BX
	XOR	SI,SI
@@loop1:
	mov al,[msg+si]
	cmp	al,' '
	je @@1
	cmp	al,57h
	je @@2
	inc si
	jmp toloop
@@1:
	mov [text+bx],32d
	inc	bx
	mov [text+bx],03Ah
	inc bx
	jmp toloop
@@2:
	mov [text+bx],219d
	inc	bx
	mov [text+bx],39h
	inc bx
	jmp toloop
toloop:
	inc si
	loop	@@loop1
	pop	si
	pop	cx
	pop	bx
	pop	ax
	assume es:nothing
	push ds
	pop es
	ret
endp	ChangeScreen
proc	OpenFile
	mov ah, 3Dh
	int 21h
	ret
endp	OpenFile
proc	ReadFile
	mov ah,3Fh	
	int 21h
	ret
endp	ReadFile
proc CloseFile
	mov ah,3Eh	
	int 21h
	ret
endp CloseFile
;When you you need to use music
proc TurnOnMusic
;The function will save the save the sec and the milisec
;and turn on the music
; entry sequence
;
arg	SecAddres:word, \
	MinAddres:word, \
	Note:word,	\
	Timechange:byte	\
	=prm_size
	
    push	bp
    mov 	bp, sp
;
;Get system time and put it in min and sec
;
	mov ah,2ch
	int 21h
	mov bl,[Timechange]
	add	dl,bl
	mov bx,[SecAddres]
	mov [bx],dh
	mov bx,[MinAddres]
	mov [bx],dl
	mov al,100
	CMP	[bx],al
	JB	@@nominchange
	mov bx,[MinAddres]
	sub [bx],al
	mov bx,[SecAddres]
	mov al,1
	add [bx],al
@@nominchange:
	mov bx,[SecAddres]
	mov al,60
	CMP	[BX],al
	JB	@@nosecchange
	sub [BX],al
@@nosecchange:
; open speaker
	in al, 61h 
	or al, 00000011b 
	out 61h, al 
; send control word to change frequency
	mov al, 0B6h
	out 43h, al
; play frequency 
	mov ax, [Note]
	out 42h, al ; Sending lower byte 
	mov al, ah
	out 42h, al ; Sending upper byte
	;
	; leave sequence
	;
	mov [musicplayed],1
	mov 	sp, bp
	pop 	bp
	ret	prm_size
endp	TurnOnMusic
proc	PrintToScreen
;
;PrintToScreen - Print text to the screen in the position
;
;Entry:	bx- the place in the text
;		si- The offset of the text
;		cx - the size
;
	push bx
LoopPrint:
	mov ax, textseg
	mov es, ax
	assume es:textseg
	mov al,[si]
	mov [text+bx],al
	mov ah,039h
	mov [text+bx+1],ah
	add bx,2
	inc si
	loop LoopPrint
	pop bx
	ret
endp	PrintToScreen
proc DrawRectangle
;This function Draw a magenta rectangle
;Cartiage
; - Upper left corner

arg Corner:word \
	=prm_size
	
	;So I can use text 
	mov ax, textseg
	mov es, ax
	assume es:textseg
	
	push	bp
    mov 	bp, sp
	;Draw the upper Edge
	xor bx,bx
	mov bx,[Corner]
	mov cx,11
	mov si,1
@@Loop1:
	mov [text+bx+si],0D9h
	add si,2
	loop @@Loop1
	
	mov si,161
	mov cx,3
@@Loop2:
	mov [text+bx+si],0D9h
	add si,20
	mov [text+bx+si],0D9h
	add si,140
	loop @@Loop2
	
	mov si,160*4+1
	mov cx,11
@@Loop3:
	mov [text+bx+si],0D9h
	add si,2
	loop @@Loop3
	
	mov 	sp, bp
    pop 	bp
    ret 	prm_size
endp DrawRectangle
proc DeleteRectangle
;This function delete a rectangle
;Cartiage
; - Upper left corner, calculated already

arg Corner:word \
	=prm_size
	
	;So I can use text 
	mov ax, textseg
	mov es, ax
	assume es:textseg
	
	push	bp
    mov 	bp, sp
	;Draw the upper Edge
	xor bx,bx
	mov bx,[Corner]
	mov cx,11
	mov si,1
@@Loop1:
	mov [text+bx+si],039h
	add si,2
	loop @@Loop1
	
	mov si,161
	mov cx,3
@@Loop2:
	mov [text+bx+si],039h
	add si,20
	mov [text+bx+si],039h
	add si,140
	loop @@Loop2
	
	mov si,160*4+1
	mov cx,11
@@Loop3:
	mov [text+bx+si],039h
	add si,2
	loop @@Loop3
	
	mov 	sp, bp
    pop 	bp
    ret 	prm_size
endp DeleteRectangle
end Initielize