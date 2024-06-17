extern sin
extern cos
extern printf
extern memset
extern usleep
extern putchar

global main
section .text

main:

	push rbp
	mov rbp, rsp

	mov rax, __?float64?__(0.0)
	movq xmm0, rax
	movq qword [rbp-8], xmm0  ; A
	movq qword [rbp-16], xmm0 ; B
	movq qword [rbp-24], xmm0 ; i
	movq qword [rbp-32], xmm0 ; j
	mov dword [rbp-36], 0     ; k
								; rbp-7076  - z[1760] float
								; rbp-8836  - b[1760] char

	lea edi, [print1]
	call printf

_main_loop: ; for(;;)

	lea rax, [rbp-8836]
	mov edx, 1760
	mov esi, 32
	mov rdi, rax
	call memset ; memset(b, 32, 1760)

	lea rax, [rbp-7076]
	mov edx, 7040
	mov esi, 0
	mov rdi, rax
	call memset ; memset(z, 0, 7040)

	mov rax, __?float64?__(0.0)
	movq xmm0, rax
	movq qword [rbp-32], xmm0
	_c_for_loop_1: ; for(j = 0; j < 6.28; j += 0.07)

		mov rax, __?float64?__(0.0)
		movq xmm0, rax
		movq qword [rbp-24], xmm0	
		_c_for_loop_2: ; for(i = 0; i < 6.28; i += 0.02)

			movq xmm0, qword [rbp-24]
			call sin
			movq qword [rbp-8844], xmm0 ; c = sin(i)

			movq xmm0, qword [rbp-32]
			call cos
			movq qword [rbp-8852], xmm0 ; d = cos(j)

			movq xmm0, qword [rbp-8]
			call sin
			movq qword [rbp-8860], xmm0 ; e = sin(A)

			movq xmm0, qword [rbp-32]
			call sin
			movq qword [rbp-8868], xmm0 ; f = sin(j)

			movq xmm0, qword [rbp-8]
			call cos
			movq qword [rbp-8876], xmm0 ; g = cos(A)

			movq xmm0, qword [rbp-8852]
			mov rax, __?float64?__(2.0)
			movq xmm1, rax
			addsd xmm0, xmm1
			movq qword [rbp-8884], xmm0 ; h = d + 2.0

			movq xmm0, qword [rbp-8844]
			movq xmm1, qword [rbp-8884]
			mulsd xmm0, xmm1 ; c * h
			movq xmm1, qword [rbp-8860]
			mulsd xmm0, xmm1 ; * e

			movq xmm2, qword [rbp-8868]
			movq xmm3, qword [rbp-8876]
			mulsd xmm2, xmm3 ; f * g

			addsd xmm0, xmm2
			mov rax, __?float64?__(5.0)
			movq xmm3, rax
			addsd xmm0, xmm3
			movq qword [rbp-8890], xmm0 ; D = 1 / (c * h * e + f * g + 5)

			movq xmm0, qword [rbp-24]
			call cos
			movq qword [rbp-8898], xmm0 ; l = cos(i)

			movq xmm0, qword [rbp-16]
			call cos
			movq qword [rbp-8906], xmm0 ; m = cos(B)

			movq xmm0, qword [rbp-16]
			call sin
			movq qword [rbp-8914], xmm0 ; n = sin(B)

			movq xmm0, qword [rbp-8844]
			movq xmm1, qword [rbp-8884]
			mulsd xmm0, xmm1
			movq xmm1, qword [rbp-8876]
			mulsd xmm0, xmm1

			movq xmm2, qword [rbp-8868]
			movq xmm3, qword [rbp-8860]
			mulsd xmm2, xmm3

			subsd xmm0, xmm2
			movq qword [rbp-8922], xmm0 ; t = c * h * g - f * e

			movq xmm0, qword [rbp-8898]
			movq xmm1, qword [rbp-8884]
			mulsd xmm0, xmm1
			movq xmm1, qword [rbp-8906]
			mulsd xmm0, xmm1

			movq xmm2, qword [rbp-8922]
			movq xmm3, qword [rbp-8914]
			mulsd xmm2, xmm3

			subsd xmm0, xmm2

			mov rax, __?float64?__(30.0)
			movq xmm4, rax
			movq xmm5, qword [rbp-8890]
			mulsd xmm4, xmm5

			mulsd xmm0, xmm4

			mov rax, __?float64?__(40.0)
			movq xmm1, rax
			addsd xmm0, xmm1

			cvttsd2si eax, xmm0
			mov dword [rbp-8926], eax ; x = 40 + 30 * D * (l * h * m - t * n)

			movq xmm0, qword [rbp-8898]
			movq xmm1, qword [rbp-8884]
			mulsd xmm0, xmm1

			movq xmm1, qword [rbp-8914]
			mulsd xmm0, xmm1

			movq xmm2, qword [rbp-8922]
			movq xmm3, qword [rbp-8906]
			mulsd xmm2, xmm3

			addsd xmm0, xmm2

			mov rax, __?float64?__(15.0)
			movq xmm4, rax
			movq xmm5, qword [rbp-8890]
			mulsd xmm4, xmm5

			mulsd xmm0, xmm4

			mov rax, __?float64?__(12.0)
			movq xmm1, rax

			addsd xmm0, xmm1

			cvttsd2si eax, xmm0
			mov dword [rbp-8930], eax ; y = 12 + 15 * D * (l * h * n + t * m)

			mov eax, 80
			mov edx, dword [rbp-8930]
			mul edx

			add eax, dword [rbp-8926]
			mov dword [rbp-8934], eax ; o = x + 80 * y

			movq xmm0, qword [rbp-8868]
			movq xmm1, qword [rbp-8860]
			mulsd xmm0, xmm1
			
			movq xmm2, qword [rbp-8844]
			movq xmm3, qword [rbp-8852]
			movq xmm4, qword [rbp-8876]

			mulsd xmm2, xmm3
			mulsd xmm2, xmm4

			subsd xmm0, xmm2
			movq xmm2, qword [rbp-8906]
			mulsd xmm0, xmm2 ; first part of equation in xmm0

			movq xmm1, qword [rbp-8844]
			movq xmm2, qword [rbp-8852]
			movq xmm3, qword [rbp-8860]
			mulsd xmm1, xmm2
			mulsd xmm2, xmm3 
			movsd xmm1, xmm2 ; second part of equation in xmm1

			movq xmm2, qword [rbp-8868]
			movq xmm3, qword [rbp-8876]
			mulsd xmm2, xmm3 ; third part of equation in xmm2

			movq xmm3, qword [rbp-8898]
			movq xmm4, qword [rbp-8852]
			movq xmm5, qword [rbp-8914]
			mulsd xmm3, xmm4
			mulsd xmm4, xmm5
			movsd xmm3, xmm4 ; fourth part of equation in xmm3

			subsd xmm0, xmm1
			subsd xmm0, xmm2
			subsd xmm0, xmm3

			cvttsd2si eax, xmm0
			mov dword [rbp-8938], eax ; N = 8 * ((f * e - c * d * g) * m - c * d * e - f * g - l * d * n) (omg please help me)

			mov eax, 22
			mov ebx, dword [rbp-8930]
			cmp eax, ebx
			jg _c_if_1
			jmp _c_endif_1

			_c_if_1:
				mov eax, dword [rbp-8930]
				mov ebx, 0
				cmp eax, ebx
				jg _c_if_1
				jmp _c_endif_1

				_c_if_2:
					mov eax, dword [rbp-8926]
					mov ebx, 0
					cmp eax, ebx
					jg _c_if_3
					jmp _c_endif_1

					_c_if_3:
						mov eax, 80
						mov ebx, dword [rbp-8926]
						cmp eax, ebx
						jg _c_if_4
						jmp _c_endif_1

						_c_if_4:
							movsx rax, dword [rbp-8934] 
							movq xmm0, qword [rbp-8890]
							movq xmm1, qword [rbp-7076+rax*4]
							pcmpeqq xmm0, xmm1
							jg _c_if_5
							jmp _c_endif_1

							_c_if_5:
								movq qword [rbp-7076+rax*4], xmm0

								mov eax, dword [rbp-8938]
								mov edx, 0
								test eax, eax
								cmovs eax, edx
								cdqe
								movzx eax, byte [chars+rax]

								movsx rax, dword [rbp-8934] 
								mov dword [rbp-8836+rax], eax


			_c_endif_1:

			;end of loop
			movq xmm0, qword [rbp-24]
			mov rax, __?float64?__(0.02)
			movq xmm1, rax
			addsd xmm0, xmm1
			movq qword [rbp-32], xmm0

			mov rax, __?float64?__(6.28)
			movq xmm0, rax
			movq xmm1, qword [rbp-24]
			pcmpeqq xmm0, xmm1
			jl _c_for_loop_2
	


		;end of loop
		movq xmm0, qword [rbp-32]
		mov rax, __?float64?__(0.07)
		movq xmm1, rax
		addsd xmm0, xmm1
		movq qword [rbp-32], xmm0

		mov rax, __?float64?__(6.28)
		movq xmm0, rax
		movq xmm1, qword [rbp-32]
		pcmpeqq xmm0, xmm1
		jl _c_for_loop_1

		lea edi, [print2]
		call printf

		; rbp-36	
		mov dword [rbp-36], 0
		_c_for_loop_3: ; for(k = 0; k < 1761; k++)

			mov eax, dword [rbp-8938]
			mov edx, 0

			mov ebx, 80
			div ebx
			test edx, edx
			je _c_if_6
			mov edi, 10
			jmp _c_endif_6

			_c_if_6:
				mov eax, dword [rbp-36]
				movsx rax, eax
				mov edi, dword [rbp-8836+rax]

			_c_endif_6:
			
			call putchar

			mov rax, __?float64?__(0.00004)
			movq xmm0, rax
			mov rax, __?float64?__(0.00002)
			movq xmm1, rax
			
			movq xmm2, qword [rbp-8]
			movq xmm3, qword [rbp-16]

			addsd xmm2, xmm0
			addsd xmm3, xmm1
			
			movq qword [rbp-8], xmm2
			movq qword [rbp-16], xmm3

			mov eax, dword [rbp-36]
			inc eax
			mov dword [rbp-36], eax

			mov ebx, 1761
			cmp eax, ebx
			jl _c_for_loop_3

		mov edi, 30000
		call usleep

	jmp _main_loop

	mov eax, 0
	leave
	ret

section .data
print1 db 27, "[2J", 0 ; \x1b[2J
print2 db 27, "[H", 0  ; \x1b[H
chars db ".,-~:;=!*#$@"
