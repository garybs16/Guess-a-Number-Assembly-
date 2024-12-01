
; =============================================================
; CMPR-154 Final Project: Guessing Game
; Class Name: CMPR-154
; Team Name: Team Whatever
; Team Members: Annalucia Martinez, Gary Samuel, 
; Jairo Villanos
; Creation Date: 11/23/2024
; Collaboration: Assistance using StackOverflow and TextBook 
; Contribution : Gary (working on case 3-4), Annalucia (applying function, case 2, and coloring), Jairo (Menu display, case 1)
; =============================================================




INCLUDE Irvine32.inc

.data

lineRightNumber BYTE "=> The right number is: ", 0

lineTop1 BYTE "  _____                             _     ",0
lineTop2 BYTE " / ____|                           | |     ",0
lineTop3 BYTE "| |  __  __ _ _ __ ___   ___  _ __| |_    ",0
lineTop4 BYTE "| | |_ |/ _` | '_ ` _ \ / _ \| '__| __|   ",0
lineTop5 BYTE "| |__| | (_| | | | | | | (_) | |  | |_     ",0
lineTop6 BYTE " \_____|\__,_|_| |_| |_|\___/|_|   \__|    ",0
lineTop7 BYTE "    *** LETS PLAY GUESSING GAME***                            ",0


lineTop BYTE "*** GUESSING GAME ***",0
line0 BYTE "*** TEAM WHATEVER ***",0

line2 BYTE "*** MAIN MENU ***",0
line3 BYTE "Please select one of the following:",0
line4 BYTE "    1. Display my available credit",0
line5 BYTE "    2. Add credits to my account",0
line6 BYTE "    3. Play the guessing game",0
line7 BYTE "    4. Display my statistics",0
line8 BYTE "    5. To exit",0

    lineBalance BYTE "=> Your available balance is: $",0
    lineEnd BYTE "Thank you for playing our game!",0
    lineEnter BYTE "=> Please enter the amount you would like to add: $",0
    lineError1 BYTE "=> Error: Maximum allowable credit is $20.00.",0
    lineError2 BYTE "=> Please enter a different amount and try again",0
    lineError3 BYTE "=> Invalid input, The option is between 1-5", 0

    balance SDWORD 0
    lineDecimal BYTE ".00",0
    MAX_ALLOWED SDWORD 20
    amount SDWORD 0
    correctGuesses SDWORD 0
    missedGuesses SDWORD 0
    userName BYTE 21 DUP(0)
    case4line2 BYTE "Available credit: $",0
    case4line3 BYTE "Games played: ",0
    case4line4 BYTE "Correct Guesses: ",0
    case4line5 BYTE "Missed Guesses: ",0
    case4line6 BYTE "Money you won is: $",0
    case4line7 BYTE "Money you lost is: $",0
    enterNameLine1 BYTE "You have not yet entered your name, please enter your name^^",0
    enterNameLine2 BYTE "Enter your name: ",0
    nameHasString SDWORD 0
    case3line1 BYTE "Please Guess a number between 1 and 10: ",0
    userNumber SDWORD ?
    generatedNumber SDWORD 0
    case3line2 BYTE "Playing the game costs $1. Press 1 to keep playing the game or 2 to go back to the menu: ",0

    case3Correct BYTE "=> Correct! You won $2.", 0
    case3Wrong BYTE "=> Incorrect! Better luck next time.", 0
    case3NoFunds BYTE "=> Insufficient funds to play the game.", 0

.code

invalidPlayChoice BYTE "=> Invalid choice. Please enter 1 to play or 2 to go back.",0
invalidGuessMessage BYTE "=> Invalid guess. Please pick a number between 1 and 10.",0

WriteDisplay proc


    mov eax, red    ; Set text color to red for the title
    call setTextColor

    mov edx, OFFSET lineTop1   ; Display ASCII art title line by line
    call WriteString
    call Crlf
    mov edx, OFFSET lineTop2
    call WriteString
    call Crlf
    mov edx, OFFSET lineTop3
    call WriteString
    call Crlf

    mov edx, OFFSET lineTop4
    call WriteString
    call Crlf
    mov edx, OFFSET lineTop5
    call WriteString
    call Crlf
    mov edx, OFFSET lineTop6
    call WriteString
    call Crlf
    mov edx, OFFSET lineTop7
    call WriteString
    call Crlf

    
    mov eax, white    ; Reset text color for the menu options
    call setTextColor

    ;menu options
    call Crlf
    mov edx, OFFSET line0
    call WriteString
    call Crlf
    mov edx, OFFSET line2
    call WriteString
    call Crlf
    mov edx, OFFSET line3
    call WriteString
    call Crlf
    mov edx, OFFSET line4
    call WriteString
    call Crlf
    mov edx, OFFSET line5
    call WriteString
    call Crlf
    mov edx, OFFSET line6
    call WriteString
    call Crlf
    mov edx, OFFSET line7
    call WriteString
    call Crlf
    mov edx, OFFSET line8
    call WriteString
    call Crlf
    ret



    mov eax, red
    call setTextColor  ;making a color 

    mov edx, OFFSET lineTop
    call WriteString

    mov eax, white
    call setTextColor

    call Crlf
    mov edx, OFFSET line0
    call WriteString
    call Crlf
    mov edx, OFFSET line2
    call WriteString
    call Crlf
    mov edx, OFFSET line3
    call WriteString
    call Crlf
    mov edx, OFFSET line4
    call WriteString
    call Crlf
    mov edx, OFFSET line5
    call WriteString
    call Crlf
    mov edx, OFFSET line6
    call WriteString
    call Crlf
    mov edx, OFFSET line7
    call WriteString
    call Crlf
    mov edx, OFFSET line8
    call WriteString
    call Crlf
    ret

WriteDisplay endp

main proc
  mov ecx, 1
again:
    call ClrScr        ; Clear the console screen for the main menu
    call WriteDisplay  ; Display the main menu

menuSelection:
    call ReadInt       ; Read user choice

    ; Validate input is between 1 and 5
    cmp eax, 1
    jl invalidInput    
    cmp eax, 5
    jg invalidInput    

    ; Jump to corresponding case
    cmp eax, 1
    je case1
    cmp eax, 2
    je case2
    cmp eax, 3
    je case3
    cmp eax, 4
    je case4
    cmp eax, 5
    je case5

invalidInput:
    ; Notify the user and re-prompt
    mov edx, OFFSET lineError3 ; Replace with a simple "Invalid input" message

    call WriteString
    call Crlf
    
    jmp menuSelection          ; Retry input



case1:
    mov edx, OFFSET lineBalance
    call WriteString
    mov eax, balance
    call WriteDec
    mov edx, OFFSET lineDecimal
    call WriteString
    call Crlf
    call PauseBeforeMenu  ; Pause for user to see the output
    jmp again             ; Go back to menu



case2:
    mov edx, OFFSET lineEnter
    call WriteString
    call ReadInt                 ; Read the amount of money the user wants to add
    mov amount, eax            ; Store the input in `amount`

    ; Check if the current balance is already $20
    mov eax, balance            ; Load the current balance
    cmp eax, MAX_ALLOWED         ; Compare balance with $20
    je maxBalanceReached       ; If balance is already $20, jump to error handling

    ; Check if adding the input would exceed $20
    add eax, amount            ; Add the input amount to the current balance
    cmp eax, MAX_ALLOWED         ; Compare the total with $20
    jle allowed              ; If total <= $20, allow the addition

    ; If total > $20, inform the user and loop back
    jmp notAllowed
   
allowed:
    mov balance, eax             ; Update the balance
    call PauseBeforeMenu          ; Pause for user to see the output
    jmp again                  ; Return to the main menu

notAllowed:
    mov edx, OFFSET lineError1 ; Displaying error message for exceeding limit
    call WriteString
    call Crlf
    mov edx, OFFSET lineError2
    call WriteString
    call Crlf
    call PauseBeforeMenu     ; Pause for user to view the output
    call WriteDisplay
    jmp case2                 ; Prompt user again

maxBalanceReached:
    mov edx, OFFSET lineError1 ; Display error for max balance already reached
    call WriteString
    call Crlf
    call PauseBeforeMenu      ; Pause for user to view the output
    jmp again                ; Return to the main menu



case3:
promptStart:
    ; Check if the player has enough money to play
    mov eax, balance        ; Load current balance
    cmp eax, 1              ; Is balance at least $1?
    jl insufficientFunds     ; If not, inform the player and return to menu

    ; Deduct $1 to play immediately
    mov eax, balance
    sub eax, 1              ; Subtract $1
    mov balance, eax       ; Update balance

    ; Generate a random number between 1 and 10
    call Randomize
    mov eax, 10
    call RandomRange
    add eax, 1                ; Adjust result to be in the range 1-10
    mov generatedNumber, eax

guessNumber:
    mov edx, OFFSET case3line1
    call WriteString
    call ReadInt            ; Get the player's guess
    mov userNumber, eax     ; Store user's guess

    ; Validate that the guess is between 1 and 10
    cmp userNumber, 1
    jl invalidGuess          ; If less than 1, invalid guess
    cmp userNumber, 10
    jg invalidGuess           ; If greater than 10, invalid guess

    ; Compare the player's guess with the generated number
    mov eax, userNumber
    cmp eax, generatedNumber
    je correctGuess           
    jne wrongGuess            

invalidGuess:
    ; Notify the player about the invalid guess
    mov edx, OFFSET invalidGuessMessage
    call WriteString
    call Crlf
    call PauseBeforeMenu       ; Pause for user to view the message
    call WriteDisplay           ; Re-display the menu
    jmp guessNumber             ; Re-prompt user without leaving the case

correctGuess:
    mov edx, OFFSET case3Correct
    call WriteString          ; Congratulate the player
    call Crlf

    ; Display the right number
    mov edx, OFFSET lineRightNumber
    call WriteString
    mov eax, generatedNumber
    call WriteDec
    call Crlf

    mov eax, balance
    add eax, 2                 ; Reward $2
    mov balance, eax          ; Updating the balance
    inc correctGuesses         ; Increment correct guesses count
    call PauseBeforeMenu      ; Pause 
    call WriteDisplay          ; Re-display the menu
    jmp askRedo               ; Ask if they want to play the game again

wrongGuess:
    mov edx, OFFSET case3Wrong
    call WriteString        
    call Crlf

    ; Display the right number
    mov edx, OFFSET lineRightNumber
    call WriteString
    mov eax, generatedNumber
    call WriteDec
    call Crlf

    inc missedGuesses          ; Increment missed guesses count
    call PauseBeforeMenu     ; Pause for them to read the message
    call WriteDisplay         ; Re-display the menu
    jmp askRedo             ; Ask if they want to play again

askRedo:
    mov edx, OFFSET case3line2
    call WriteString
    call ReadInt            ; Read user's response
    cmp eax, 1
    je promptStart           ; If they want to play again, restart the game
    cmp eax, 2
    je returnToMenu           ; If they want to exit, return to the main menu
    ; Invalid input, ask again
    mov edx, OFFSET invalidPlayChoice
    call WriteString
    call Crlf
    call PauseBeforeMenu      ; Pause for user to view the message
    call WriteDisplay         ; Re-display the menu
    jmp askRedo               ; Retry input

insufficientFunds:
    mov edx, OFFSET case3NoFunds
    call WriteString
    call PauseBeforeMenu      ; Pause for them to read the message
    call WriteDisplay         ; Re-display the menu
    jmp returnToMenu          ; Return to the main menu
returnToMenu:
    jmp again                 ; Go back to the main menu




case4:  
    mov esi, OFFSET userName   ; Check if the user has entered their name
    mov al, [esi]
    cmp al, 0
    je promptName  ; If no name, prompt the user to enter it

displayStats:
 
    mov edx, OFFSET userName  ; Display user name
    call WriteString
    call Crlf
    
    mov edx, OFFSET case4line2  ; Display available credit
    call WriteString
    mov eax, balance
    call WriteDec
    mov edx, OFFSET lineDecimal
    call WriteString
    call Crlf

    mov eax, correctGuesses   ; Calculate total games played (correct + missed guesses)
    add eax, missedGuesses
    mov edx, OFFSET case4line3
    call WriteString
    call WriteDec
    call Crlf

    mov edx, OFFSET case4line4   ; Display correct guesses
    call WriteString
    mov eax, correctGuesses
    call WriteDec
    call Crlf

    mov edx, OFFSET case4line5   ; Display missed guesses
    call WriteString
    mov eax, missedGuesses
    call WriteDec
    call Crlf

    mov edx, OFFSET case4line6    ; Display money won (correct guesses * $2)
    call WriteString
    mov eax, correctGuesses
    imul eax, 2
    call WriteDec
    call Crlf

    mov edx, OFFSET case4line7    ; Display money lost (missed guesses * $1)
    call WriteString
    mov eax, missedGuesses
    call WriteDec
    call Crlf

    call PauseBeforeMenu      ; Pause before returning to menu
    jmp again  ; Return to main menu

promptName:

    mov edx, OFFSET enterNameLine1    ; Prompt user to enter their name if not already entered
    call WriteString
    call Crlf
    mov edx, OFFSET enterNameLine2
    call WriteString
    mov edx, OFFSET userName
    mov ecx, SIZEOF userName
    call ReadString
    jmp displayStats


case5: 

    mov edx, OFFSET lineEnd
    call WriteString
    call Crlf
    exit

PauseBeforeMenu proc
    call Crlf
    ; mov edx, OFFSET line0
; call WriteString
    call WaitMsg          ; Wait for user input before clearing the screen
    call ClrScr           ; Clear the screen
    ret
PauseBeforeMenu endp


done:
    call Crlf
    cmp ecx, 1
    je again
    call WaitMsg
    exit


main endp
end main

;HORRAYYYYYYYY HAPPPY THANKSGIVINGGGGGGGGGGGGGGGGG