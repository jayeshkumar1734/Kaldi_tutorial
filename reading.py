tran=[]
with open('exp_1/mono0a/decode4_test_yesno/scoring/11.tra', 'r') as test_text:
    text=test_text.read()
    text1=text.split("\n")
    #print(text1)
    for line in text1:
        #print(line)
        tran.append(line)

final=[]
for i in range(len(tran)):
    tran_line=tran[i].split(" ")
    #print(tran_line)
    b=[]
    for j in range(1,len(tran_line)):
        a=str(tran_line[j])
        b.append(a+" ")
    #print(b)
    final.append(b)

for i in range(len(final)):
    words=""
    #print(final[i],str(3))
    for j in range(len(final[i])):
        #print(final[i][j])
        if final[i][j]=="3 ":
            final[i][j]="YES"
            #print(str(3))
        if final[i][j]=="2 ":
            final[i][j]="NO"
        words=words+final[i][j]+" "
    print(words)
