//
//  MyCalculatorViewController.h
//  calculator
//
//  Created by Eric on 13-10-19.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import "calculatClass.h"

@implementation calculatClass

int error;
char ops[8]={'+','-','*','/','%','(',')','#'};
//0='>',1='<',2='='.
int op_priority[8][8]={
    {0,0,1,1,1,1,0,0},
    {0,0,1,1,1,1,0,0},
    {0,0,0,0,0,1,0,0},
    {0,0,0,0,0,1,0,0},
    {0,0,0,0,0,1,0,0},
    {1,1,1,1,1,1,2,0},
    {0,0,0,0,0,0,0,0},
    {1,1,1,1,1,1,0,2}
};
int index_op(char op){
    int i=0;
    for(i=0;i<8;i++)
        if(op==ops[i])
            break;
    return i;
}
int Precede(char op1,char op2){
    return op_priority[index_op(op1)][index_op(op2)];
}
//后缀转中缀
void changeEXP(char Exp[],char ansExp[],int state[]){
    int i,j;
    i=0,j=0;
    char stack_ops[100]={'#'};
    int top=0;
    while(Exp[i]!='\0'){
        if((Exp[i]>='0'&&Exp[i]<='9')||Exp[i]=='.'||((Exp[i]=='-'||Exp[i]=='+')&&state[i]!=0)){//数字
            while((Exp[i]>='0'&&Exp[i]<='9')||Exp[i]=='.'||((Exp[i]=='-'||Exp[i]=='+')&&state[i]!=0)){
                if(Exp[i]=='-')
                    ansExp[j++]='N',i++;
                else if(Exp[i]=='+')
                    ansExp[j++]='Z',i++;
                else
                    ansExp[j++]=Exp[i++];
            }
            ansExp[j++]='#';
        }
        else{//运算符
            switch (Precede(stack_ops[top], Exp[i])) {
                case 0://栈顶运算符优先级更高,出栈
                    ansExp[j++]=stack_ops[top--];
                    if(top==-1){
                        error=1;
                        return;
                    }
                    break;
                case 1://栈顶运算符的优先级更低,入栈
                    stack_ops[++top]=Exp[i++];
                    break;
                default://左右括号相遇
                    top--;
                    if(top==-1){
                        error=1;
                        return;
                    }
                    i++;
                    break;
            }
        }
    }
    while(stack_ops[top]!='#'){
        ansExp[j++]=stack_ops[top--];
    }
    ansExp[j]='\0';
}
float calculateExp(char Exp[],int state[]){
    float stack_Num[100];
    int i=0,top=-1,fuhao;
    float a,b,d,k;
    if(Exp[i]=='\0'){
        error=1;
        return 0;
    }
    while(Exp[i]!='\0'){
        switch (Exp[i]) {
            case '+':
                a=stack_Num[top--];
                if(top==-1){
                    error=1;
                    return 0;
                }
                b=stack_Num[top--];
                stack_Num[++top]=a+b;
                break;
            case '-':
                a=stack_Num[top--];
                if(top==-1){
                    error=1;
                    return 0;
                }
                b=stack_Num[top--];
                stack_Num[++top]=b-a;
                break;
            case '*':
                a=stack_Num[top--];
                if(top==-1){
                    error=1;
                    return 0;
                }
                b=stack_Num[top--];
                stack_Num[++top]=a*b;
                break;
            case '%':
                a=stack_Num[top--];
                if(top==-1){
                    error=1;
                    return 0;
                }
                b=stack_Num[top--];
                if((int)b!=b||(int)a!=a){
                    error=2;
                    return 0;
                }
                stack_Num[++top]=(int)b%(int)a;
                break;
            case '/':
                a=stack_Num[top--];
                if(top==-1){
                    error=1;
                    return 0;
                }
                b=stack_Num[top--];
                if(a!=0)
                    stack_Num[++top]=b/a;
                else{
                    error=1;
                    return 0;
                }
                break;
            case '(':
            case ')':
                error=1;
                return 0;
                break;
            default:
                fuhao=1;
                if(Exp[i]=='N')
                    fuhao=-1,i++;
                else if(Exp[i]=='Z')
                    fuhao=1,i++;
                d=0;
                while(Exp[i]>='0'&&Exp[i]<='9'){
                    d=d*10+Exp[i]-'0';
                    i++;
                }
                if(Exp[i]=='.'){
                    i++;
                    k=0.1;
                    while(Exp[i]>='0'&&Exp[i]<='9'){
                        d+=k*(Exp[i]-'0');
                        k*=0.1;
                        i++;
                    }
                }
                stack_Num[++top]=d*fuhao;
                break;
        }
        i++;
    }
    if(top!=0){
        error=1;
        return 0;
    }
    return stack_Num[top];
}
+(float) calculatFun:(NSString *)Exp  withState:(int [])state{
    char postExp[100];
    error=0;
    changeEXP([Exp cStringUsingEncoding:NSASCIIStringEncoding], postExp,state);
    return calculateExp(postExp,state);
}
+(int)errorID{
    return error;
}
@end
