;Chua Edric Jarvis S14
%include "io.inc"

section .data
  input times 128 db 0  
  digits times 128 dd 0  
  sum_powered_digits dd 0
  count dd 0   
  counter dd 0 
  counter_mod dd 0  
  comma_counter dd 0
  decimal_input dd 0  
  
section .text          
global main
main:
    mov ebp, esp ; for correct debugging

    PRINT_STRING "Input Number: "
    GET_STRING input, 128  
    
  
    mov esi, input
    cmp byte [esi], '-'      ; check if input is negative
    je ERROR2              
    cmp byte [esi], '0'
    jb ERROR1
    cmp byte [esi], '9'      ; check if first digit is greater than 9
    ja ERROR1
    
    ; Calculate sum of digits
    lea esi, [input]     
    xor eax, eax        
    xor ebx, ebx        
        
    mov dword [count], 0    
    mov dword [decimal_input], 0
    
    
convertion:
  
    mov bl, byte [esi]   ; get current character
    cmp byte [esi], `\0`
    je OK
    cmp byte [esi], `\n`
    je OK
    
    sub bl, 48           
    imul eax, 10       
    add eax, ebx         
    inc esi             
    inc dword [count]        
    cmp byte [esi], 0       
    jne convertion         
   
  
   
OK:  

    add [decimal_input], eax 
    PRINT_STRING "m-th power of each digit: "  
    mov dword [counter_mod], 0
    mov dword [digits], 0
    mov dword [sum_powered_digits], 0 
    mov dword [comma_counter], 1
   
     
Answer:

  
    mov eax, dword[decimal_input]    
 
     

  mov ebx, 10
  mov ecx, dword[count]    ; index for digits array
  sub ecx, 1
  
loop1:

  xor edx, edx
  div ebx      ; divide by 10, remainder is in edx

   mov dword [digits + ecx*4], edx

  
  dec ecx 
  
cmp eax, 0
 jne loop1
  

       
        print_digits:
        mov ecx, dword[counter_mod]
        mov eax, dword [digits + ecx*4]
        mov dword [counter], 1
   
        mov ebx, eax
     

        cmp ecx, dword[count]
        je SUM_ANSWER
        
        mov eax, 1
       
        loop2:
        
            mul ebx ; raising
            mov ecx, dword[counter]
            inc dword[counter]
            cmp ecx, dword[count]
            jne loop2     
            add dword[sum_powered_digits], eax
            PRINT_DEC 4, eax 
      
        call commaa
            
       
    
        inc dword[counter_mod]
        jmp print_digits  
                                                         
     
                                                                                                                                                 

SUM_ANSWER:    
    NEWLINE
    PRINT_STRING "Sum of the m-th power digits: "   
    PRINT_DEC 4, sum_powered_digits ; lower eax ; upper edx
    NEWLINE 
     mov eax, dword[decimal_input]
     Cmp eax, dword[sum_powered_digits] 
     je ARMSTRONG 
  
     PRINT_STRING "Armstrong Number: No "
     Jmp RESTART      
    
     
    
ARMSTRONG:   
                         
      PRINT_STRING "Armstrong Number: Yes "                                                                                          
                                                                                                                                                    
  
    
  Jmp RESTART       
        
          
            
                
RESTART:
    NEWLINE
    PRINT_STRING "Do you want to continue (Y/N)? "
    NEWLINE
    GET_STRING input, 128            
    cmp byte [input], 'y'             
    je main                              
    cmp byte [input], 'Y'              
    je main                                
    
    ; Exit program
    xor eax, eax                           
    ret


commaa:
    mov ecx, dword[comma_counter]
    cmp ecx, dword[count]
    jl yescomma
    INC dword[comma_counter]
    ret
    
yescomma:       
    PRINT_CHAR ','
    INC dword[comma_counter]
    ret
   
    
ERROR1:
    PRINT_STRING "Error: Invalid Input"   

    JMP RESTART                           
      
ERROR2:
    PRINT_STRING "Error: Negative Input"   
    JMP RESTART                            