program ordenacao;//////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//TRABALHO DE ALGORITIMOS E ESTRUTURA DE DADOS                                //
//ALUNOS: OTAVIO AUGUSTO CHAVES - 0002912                                     //
//        JOAO PAULO CAMPOS RIBEIRO - 0011914                                 //
////////////////////////////////////////////////////////////////////////////////
{$mode objfpc}{$H+}
uses
  {$IFDEF UNIX}{$ENDIF}
  Classes, SysUtils, CustApp;
type Tordenacao = record//DECLARACAO DO TIPO ORDENACAO//////////////////////////
  tempo_bubble,tempo_selection,tempo_inserction,tempo_shell,tempo_heap,
  tempo_quick_inicio,tempo_quick_meio,tempo_quick_fim,tempo_quick_random,
  tempo_quick_mediana,tempo_quick_intro:double;

  compara_bubble,compara_selection,compara_inserction,compara_shell,
  compara_heap,compara_quick_inicio,compara_quick_meio,compara_quick_fim,
  compara_quick_random,compara_quick_mediana,compara_quick_intro:double;

  troca_bubble,troca_selection,troca_inserction,troca_shell,troca_heap,
  troca_quick_inicio,troca_quick_meio,troca_quick_fim,troca_quick_random,
  troca_quick_mediana,troca_quick_intro:double;
end;
////////////////////////////////////////////////////////////////////////////////
const ntest=100;//CONSTANTE DO NUMERO DE TESTES///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
function verifica(sequencia:array of longint;n:integer):boolean;//VERIFICA//////
  var
    i:integer;
  begin
    verifica:=true;
    for i:=1 to n-1 do begin
      if (sequencia[i]>sequencia[i+1])
        then verifica:=false;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
procedure bubble(sequencia:array of longint;n:integer;//BUBBLE//////////////////
  var soma,cont_comp,cont_troca:double);
var
  i,j,aux:integer;
  tempoi,tempof:real;
  t1,t2:ttimestamp;
begin
  t1:=DateTimeToTimeStamp(now);
  tempoi:=TimeStampToMSecs(t1);
  for i:=1 to n do begin
    for j:=i+1 to n do begin
      cont_comp:=cont_comp+1;
      if sequencia[i]>sequencia[j] then begin
        aux:=sequencia[i];
        sequencia[i]:=sequencia[j];
        sequencia[j]:=aux;
        cont_troca:=cont_troca+1;
      end;
    end;
  end;
  t2:=DateTimeToTimeStamp(now);
  tempof:=TimeStampToMSecs(t2);
  soma:=soma+tempof-tempoi;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure selection(sequencia:array of longint;n:integer;//SELECCTION///////////
  var soma,cont_comp,cont_troca:double);
var
  i,j,aux,menor:integer;
  tempoi,tempof:real;
  t1,t2:ttimestamp;
begin
  t1:=DateTimeToTimeStamp(now);
  tempoi:=TimeStampToMSecs(t1);
  for i:=1 to n do begin
    menor:=i;
    for j:=i+1 to n do begin
      cont_comp:=cont_comp+1;
      if sequencia[j]<sequencia[menor]
        then begin
          menor:=j;
        end;
    end;
    aux:=sequencia[i];
    sequencia[i]:=sequencia[menor];
    sequencia[menor]:=aux;
    cont_troca:=cont_troca+1;
  end;
  t2:=DateTimeToTimeStamp(now);
  tempof:=TimeStampToMSecs(t2);
  soma:=soma+tempof-tempoi;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure inserction(sequencia:array of longint;n:integer;//INSERCTION//////////
  var soma,cont_comp,cont_troca:double);
var
  i,j,c:integer;
  tempoi,tempof:real;
  t1,t2:ttimestamp;
begin
  t1:=DateTimeToTimeStamp(now);
  tempoi:=TimeStampToMSecs(t1);
  for i:=2 to n do begin
    c:=sequencia[i];
    j:=i-1;
    cont_comp:=cont_comp+1;
    while ((j>=1)and(sequencia[j]>c))do begin
      cont_comp:=cont_comp+1;
      sequencia[j+1]:=sequencia[j];
      j:=j-1;
      cont_troca:=cont_troca+1;
    end;
    sequencia[j+1]:=c;
    cont_troca:=cont_troca+1;
  end;
  t2:=DateTimeToTimeStamp(now);
  tempof:=TimeStampToMSecs(t2);
  soma:=soma+tempof-tempoi;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure shell(sequencia:array of longint;n:integer;//SHELLSORT////////////////
  var soma,cont_comp,cont_troca:double);
var
  i,j,h,x:integer;
  tempoi,tempof:real;
  t1,t2:ttimestamp;
label retorne;
begin
  t1:=DateTimeToTimeStamp(now);
  tempoi:=TimeStampToMSecs(t1);
  h:=1;
  repeat
    h:=3*h+1;
  until h>=n;
  repeat
    h:=h div 3;
    for i:=h+1 to n do begin
      x:=sequencia[i];
      j:=i;
      cont_comp:=cont_comp+1;
      while sequencia[j-h]>x do begin
        cont_comp:=cont_comp+1;
        sequencia[j]:=sequencia[j-h];
        j:=j-h;
        cont_troca:=cont_troca+1;
        if j<=h then begin
          goto retorne;
        end;
      end;
      retorne: sequencia[j]:=x;
      cont_troca:=cont_troca+1;
    end;
  until h=1;
  t2:=DateTimeToTimeStamp(now);
  tempof:=TimeStampToMSecs(t2);
  soma:=soma+tempof-tempoi;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure heap(sequencia:array of longint;n:integer;//HEAPSORT//////////////////
  var soma,cont_comp,cont_troca:double);

procedure refaz(var sequencia:array of longint;esq,dir:integer);
label retornar;
var
  i,j,aux:integer;
begin
  i:=esq;
  j:=2*i;
  aux:=sequencia[i];
  cont_comp:=cont_comp+1;
  while j<=dir do begin
    cont_comp:=cont_comp+2;
    if j< dir
      then begin
        cont_comp:=cont_comp+1;
        if sequencia[j]<sequencia[j+1]
          then begin
            j:=j+1;
          end;
      end;
    cont_comp:=cont_comp+1;
    if aux>=sequencia[j]
      then begin
        goto retornar;
      end;
    sequencia[i]:=sequencia[j];
    i:=j;
    j:=2*i;
    cont_troca:=cont_troca+1;
  end;
  retornar:sequencia[i]:=aux;
  cont_troca:=cont_troca+1;
end;

procedure constroi(var sequencia:array of integer;n:integer);
  var esq:integer;
begin
  esq:=n div 2+1;
  cont_comp:=cont_comp+1;
  while esq>1 do begin
    cont_comp:=cont_comp+1;
    esq:=esq-1;
    refaz(sequencia,esq,n);
  end;
end;

var
  esq,dir,aux:integer;
  tempoi,tempof:real;
  t1,t2:ttimestamp;
begin
  t1:=DateTimeToTimeStamp(now);
  tempoi:=TimeStampToMSecs(t1);
  constroi(sequencia,n);
  esq:=1;
  dir:=n;
  cont_comp:=cont_comp+1;
  while dir>=1 do begin
    cont_comp:=cont_comp+1;
    aux:=sequencia[1];
    sequencia[1]:=sequencia[dir];
    sequencia[dir]:=aux;
    dir:=dir-1;
    cont_troca:=cont_troca+1;
    refaz(sequencia,esq,dir);
    cont_comp:=cont_comp+1;
  end;
  t2:=DateTimeToTimeStamp(now);
  tempof:=TimeStampToMSecs(t2);
  soma:=soma+tempof-tempoi;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure quick(sequencia:array of longint;n:longint;//QUICKSORT////////////////
  var soma,cont_comp,cont_troca:double;opcao:byte);

procedure particao(esq,dir:longint;var i,j:longint);
var
  pivo,selepivo,aux:longint;
begin
  i:=esq;
  j:=dir;
  case opcao of
    1:selepivo:=j;
    2:selepivo:=(i+j)div 2;
    3:selepivo:=j;
    4:selepivo:=((((i+j) div 2)+i + j) div 3);
  end;
  pivo:=sequencia[selepivo];
  repeat
    cont_comp:=cont_comp+1;
    while pivo>sequencia[i] do begin
      cont_comp:=cont_comp+1;
      i:=i+1;
    end;
    cont_comp:=cont_comp+1;
    while pivo<sequencia[j] do begin
      cont_comp:=cont_comp+1;
      j:=j-1;
    end;
    cont_comp:=cont_comp+1;
    if i<=j then begin
      aux:=sequencia[i];
      sequencia[i]:=sequencia[j];
      sequencia[j]:=aux;
      i:=i+1;
      j:=j-1;
      cont_troca:=cont_troca+1;
    end;
    cont_comp:=cont_comp+1;
  until i>j;
end;

procedure ordena(esq,dir:longint);
var
  i,j:longint;
begin
  i:=esq;
  j:=dir;
  particao(esq,dir,i,j);
  cont_comp:=cont_comp+1;
  if esq<j then ordena(esq,j);
  cont_comp:=cont_comp+1;
  if i<dir then ordena(i,dir);
end;

var
  tempoi,tempof:real;
  t1,t2:ttimestamp;
begin
  t1:=DateTimeToTimeStamp(now);
  tempoi:=TimeStampToMSecs(t1);
  ordena(1,n);
  t2:=DateTimeToTimeStamp(now);
  tempof:=TimeStampToMSecs(t2);
  soma:=soma+tempof-tempoi;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure quick_random(sequencia:array of longint;n:longint;//QUICKSORT_RANDOM//
  var soma,cont_comp,cont_troca:double);

procedure Particao(Esq,Dir:longint;var i:integer);
var pivo,selepivo,aux,j:integer;
begin
  selepivo := Esq + random(Dir-Esq)+1;
  pivo:= sequencia[selepivo];
  aux:=sequencia[selepivo];
  sequencia[selepivo]:=sequencia[Dir];
  sequencia[Dir]:=aux;
  selepivo := Dir;
  i:=Esq -1;
  j:=Esq ;
  cont_comp:=cont_comp+1;
  while (j<=Dir-1) do begin
    cont_comp:=cont_comp+2;
    if(sequencia[j] <= pivo)then begin
      i:=i+1;
      aux:=sequencia[i];
      sequencia[i]:=sequencia[j];
      sequencia[j]:=aux;
      cont_troca:=cont_troca+1;
    end;
    j:=j+1;
  end;
  aux:=sequencia[i+1];
  sequencia[i+1]:=sequencia[selepivo];
  sequencia[selepivo]:=aux;
  i:=i+1;
  cont_troca:=cont_troca+1;
end;

procedure Ordena(Esq,Dir:integer);
var i:integer;
begin
  cont_comp:=cont_comp+1;
  if(Esq < Dir)then begin
    particao(Esq,Dir,i);
    Ordena(Esq, i-1);
    Ordena(i+1, Dir);
  end;
end;

var tempoinicio, tempofim : double;
    ts, ts2 : TTimeStamp;
begin
  TS := DateTimeToTimeStamp(now);
  tempoinicio := TimeStampToMSecs(TS);
  Ordena(1,n);
  TS2 := DateTimeToTimeStamp(now);
  tempofim := TimeStampToMSecs(TS2);
  soma:=soma+tempofim-tempoinicio;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure quick_intro(sequencia:array of longint;n:longint;//INTROSORT//////////
  var soma,cont_comp,cont_troca:double);

procedure Insercao(var sequencia:array of longint;n:longint);
var
  i,j,aux:longint;
begin
  i:=1;
  while(i<n) do begin
    aux := sequencia[i];
    j := i - 1;
    cont_comp:=cont_comp+1;
    while ((j>=0)and(sequencia[j]>aux))do begin
      cont_comp:=cont_comp+1;
      sequencia[j+1]:=sequencia[j];
      sequencia[j]:=aux;
      cont_troca:=cont_troca+1;
      j:=j-1;
    end;
    i:=i+1;
  end;
end;

procedure Ordena(esq, dir:longint);
var
  i,j,aux,pivo:longint;
begin
  i := esq;
  j := dir;
  if (i >= j)
    then aux:=0
    else begin
      if( (dir-esq)<(30))
        then Insercao(sequencia[esq],dir-esq+1);
      pivo:=sequencia[(esq+dir)div 2];
      while (i < j) do begin
        cont_comp:=cont_comp+1;
        while ((i<j) and (sequencia[i] < pivo)) do begin
          cont_comp:=cont_comp+1;
          i:=i+1;
        end;
        cont_comp:=cont_comp+1;
        while ((i<j) and (sequencia[j] > pivo)) do begin
          cont_comp:=cont_comp+1;
          j:=j-1;
        end;
        if (i < j)
          then begin
            aux:=sequencia[i];
            sequencia[i]:=sequencia[j];
            sequencia[j]:=aux;
            i:=i+1;
            j:=j-1;
            cont_troca:=cont_troca+1;
          end ;
      end;
      if (j < i)
        then begin
          aux:=j;
          j:=i;
          i:=aux;
        end;
      Ordena(esq,i);
      if(i=esq)
        then Ordena(i+1,dir)
        else Ordena(i,dir);
    end;
end;

var
  tempoi,tempof:double;
  ts,ts2:TTimeStamp;
begin
  TS:=DateTimeToTimeStamp(now);
  tempoi:=TimeStampToMSecs(TS);
  Ordena(1,n);
  TS2:=DateTimeToTimeStamp(now);
  tempof:=TimeStampToMSecs(TS2);
  soma:=tempof-tempoi;
  if not verifica(sequencia,n)
    then writeln('FAILED!');
end;
////////////////////////////////////////////////////////////////////////////////
procedure Gvetor(var sequencia:array of longint;n:integer);//GERA NOVA SEQUENCIA
var i:integer;
begin
  randomize;
  for i:=1 to n do begin
    sequencia[i]:=random(n)+1;
  end;
end;
////////////////////////////////////////////////////////////////////////////////
procedure teste(var sequencia:array of longint;i,n,nteste:integer;//TESTES//////
  var tempo:array of Tordenacao);
var
  j:integer;
begin
  tempo[i].tempo_bubble:=0;
  tempo[i].tempo_selection:=0;
  tempo[i].tempo_inserction:=0;
  tempo[i].tempo_shell:=0;
  tempo[i].tempo_heap:=0;
  tempo[i].tempo_quick_inicio:=0;
  tempo[i].tempo_quick_meio:=0;
  tempo[i].tempo_quick_fim:=0;
  tempo[i].tempo_quick_random:=0;
  tempo[i].tempo_quick_mediana:=0;
  tempo[i].tempo_quick_intro:=0;

  tempo[i].compara_bubble:=0;
  tempo[i].compara_selection:=0;
  tempo[i].compara_inserction:=0;
  tempo[i].compara_shell:=0;
  tempo[i].compara_heap:=0;
  tempo[i].compara_quick_inicio:=0;
  tempo[i].compara_quick_meio:=0;
  tempo[i].compara_quick_fim:=0;
  tempo[i].compara_quick_random:=0;
  tempo[i].compara_quick_mediana:=0;
  tempo[i].compara_quick_intro:=0;

  tempo[i].troca_bubble:=0;
  tempo[i].troca_selection:=0;
  tempo[i].troca_inserction:=0;
  tempo[i].troca_shell:=0;
  tempo[i].troca_heap:=0;
  tempo[i].troca_quick_inicio:=0;
  tempo[i].troca_quick_meio:=0;
  tempo[i].troca_quick_fim:=0;
  tempo[i].troca_quick_random:=0;
  tempo[i].troca_quick_mediana:=0;
  tempo[i].troca_quick_intro:=0;

  for j:=1 to nteste do begin
    write('.');
    Gvetor(sequencia,n);
    bubble(sequencia,n,tempo[i].tempo_bubble,tempo[i].compara_bubble,tempo[i].troca_bubble);
    selection(sequencia,n,tempo[i].tempo_selection,tempo[i].compara_selection,tempo[i].troca_selection);
    inserction(sequencia,n,tempo[i].tempo_inserction,tempo[i].compara_inserction,tempo[i].troca_inserction);
    {shell(sequencia,n,tempo[i].tempo_shell,tempo[i].compara_shell,tempo[i].troca_shell);
    heap(sequencia,n,tempo[i].tempo_heap,tempo[i].compara_heap,tempo[i].troca_heap);
    quick(sequencia,n,tempo[i].tempo_quick_inicio,tempo[i].compara_quick_inicio,tempo[i].troca_quick_inicio,1);
    quick(sequencia,n,tempo[i].tempo_quick_meio,tempo[i].compara_quick_meio,tempo[i].troca_quick_meio,2);
    quick(sequencia,n,tempo[i].tempo_quick_fim,tempo[i].compara_quick_fim,tempo[i].troca_quick_fim,3);
    quick(sequencia,n,tempo[i].tempo_quick_mediana,tempo[i].compara_quick_mediana,tempo[i].troca_quick_mediana,4);
    quick_random(sequencia,n,tempo[i].tempo_quick_random,tempo[i].compara_quick_random,tempo[i].troca_quick_random);
    quick_intro(sequencia,n,tempo[i].tempo_quick_intro,tempo[i].compara_quick_intro,tempo[i].troca_quick_intro);}
  end;
  tempo[i].tempo_bubble:=tempo[i].tempo_bubble/nteste;
  tempo[i].tempo_selection:=tempo[i].tempo_selection/nteste;
  tempo[i].tempo_inserction:=tempo[i].tempo_inserction/nteste;
  tempo[i].tempo_shell:=tempo[i].tempo_shell/nteste;
  tempo[i].tempo_heap:=tempo[i].tempo_heap/nteste;
  tempo[i].tempo_quick_inicio:=tempo[i].tempo_quick_inicio/nteste;
  tempo[i].tempo_quick_meio:=tempo[i].tempo_quick_meio/nteste;
  tempo[i].tempo_quick_fim:=tempo[i].tempo_quick_fim/nteste;
  tempo[i].tempo_quick_random:=tempo[i].tempo_quick_random/nteste;
  tempo[i].tempo_quick_mediana:=tempo[i].tempo_quick_mediana/nteste;
  tempo[i].tempo_quick_intro:=tempo[i].tempo_quick_intro/nteste;

  tempo[i].compara_bubble:=tempo[i].compara_bubble/ntest;
  tempo[i].compara_selection:=tempo[i].compara_selection/ntest;
  tempo[i].compara_inserction:=tempo[i].compara_inserction/ntest;
  tempo[i].compara_shell:=tempo[i].compara_shell/ntest;
  tempo[i].compara_heap:=tempo[i].compara_heap/ntest;
  tempo[i].compara_quick_inicio:=tempo[i].compara_quick_inicio/ntest;
  tempo[i].compara_quick_meio:=tempo[i].compara_quick_meio/ntest;
  tempo[i].compara_quick_fim:=tempo[i].compara_quick_fim/ntest;
  tempo[i].compara_quick_random:=tempo[i].compara_quick_random/ntest;
  tempo[i].compara_quick_mediana:=tempo[i].compara_quick_mediana/ntest;
  tempo[i].compara_quick_intro:=tempo[i].compara_quick_intro/ntest;

  tempo[i].troca_bubble:=tempo[i].troca_bubble/ntest;
  tempo[i].troca_selection:=tempo[i].troca_selection/ntest;
  tempo[i].troca_inserction:=tempo[i].troca_inserction/ntest;
  tempo[i].troca_shell:=tempo[i].troca_shell/ntest;
  tempo[i].troca_heap:=tempo[i].troca_heap/ntest;
  tempo[i].troca_quick_inicio:=tempo[i].troca_quick_inicio/ntest;
  tempo[i].troca_quick_meio:=tempo[i].troca_quick_meio/ntest;
  tempo[i].troca_quick_fim:=tempo[i].troca_quick_fim/ntest;
  tempo[i].troca_quick_random:=tempo[i].troca_quick_random/ntest;
  tempo[i].troca_quick_mediana:=tempo[i].troca_quick_mediana/ntest;
  tempo[i].troca_quick_intro:=tempo[i].troca_quick_intro/ntest;

end;
////////////////////////////////////////////////////////////////////////////////
var//PROGRAMA PRINCIPAL/////////////////////////////////////////////////////////
  sequencia:array of longint;
  tempo:array [1..12] of Tordenacao;
  i:integer;
  n:array[1..11]of integer;
  resultado,resultadoR:text;
begin
  n[1]:=500;
  n[2]:=1000;
  n[3]:=5000;
  n[4]:=10000;
  n[5]:=30000;
  n[6]:=50000;
  n[7]:=100000;
  n[8]:=150000;
  n[9]:=200000;
  n[10]:=250000;
  n[11]:=300000;
  assign(resultado,'resultado.html');
  rewrite(resultado);
  assign(resultadoR,'resultado.txt');
  rewrite(resultadoR);
  writeln(resultado,'<html><meta charset=utf8>'
  +'<title>Teste de tempo de execucao</title>'
  +'<table border=1 align=center>'
  +'<tr><td rowspan=3 bgcolor=lightblue>Tamanho do vetor de testes</td>'
  +'<td colspan=3 rowspan=2 bgcolor=pink>Bubble</td>'
  +'<td colspan=3 rowspan=2 bgcolor=pink>Selection</td>'
  +'<td colspan=3 rowspan=2 bgcolor=pink>Inserction</td>'
  +'<td colspan=3 rowspan=2 bgcolor=pink>Shell</td>'
  +'<td colspan=3 rowspan=2 bgcolor=pink>Heap</td>'
  +'<td colspan=18 bgcolor=pink>Quick</td></tr>'
  +'<tr><td colspan=3 bgcolor=lightgreen>Inicio</td>'
  +'<td colspan=3 bgcolor=lightgreen>Meio</td>'
  +'<td colspan=3 bgcolor=lightgreen>Fim</td>'
  +'<td colspan=3 bgcolor=lightgreen>Mediana</td>'
  +'<td colspan=3 bgcolor=lightgreen>Aleatorio</td>'
  +'<td colspan=3 bgcolor=lightgreen>Introsort</td></tr>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>'
  +'<td>Tempo(ms)</td><td>Comparacoes</td><td>Trocas</td>');
  write(resultadoR,'Tamanho ');
  write(resultadoR,'Bolha_tempo Bolha_compara Bolha_troca ');
  write(resultadoR,'Selecao_tempo Selecao_compara Selecao_troca ');
  write(resultadoR,'Insercao_tempo Insercao_compara Insercao_troca ');
  write(resultadoR,'Shell_tempo Shell_compara Shell_troca ');
  write(resultadoR,'Heap_tempo Heap_compara Heap_troca ');
  write(resultadoR,'Quick_inicio_tempo Quick_inicio_compara Quick_inicio_troca ');
  write(resultadoR,'Quick_meio_tempo Quick_inicio_compara Quick_inicio_troca ');
  write(resultadoR,'Quick_fim_tempo Quick_fim_compara Quick_fim_troca ');
  write(resultadoR,'Quick_random_tempo Quick_random_compara Quick_random_troca ');
  write(resultadoR,'Quick_mediana_tempo Quick_mediana_compara Quick_mediana_troca ');
  writeln(resultadoR,'Quick_intro_tempo Quick_intro_compara Quick_intro_troca ');
  for i:= 10 to 11 do begin
    write('Testando vetores de ',n[i],' posicoes');
    setlength(sequencia,n[i]+1);
    teste(sequencia,i,n[i],ntest,tempo);
    writeln(resultado,'<tr><td bgcolor=lightblue>',n[i],'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_bubble:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_bubble:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_bubble:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_selection:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_selection:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_selection:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_inserction:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_inserction:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_inserction:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_shell:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_shell:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_shell:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_heap:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_heap:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_heap:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_quick_inicio:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_quick_inicio:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_quick_inicio:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_quick_meio:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_quick_meio:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_quick_meio:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_quick_fim:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_quick_fim:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_quick_fim:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_quick_mediana:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_quick_mediana:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_quick_mediana:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_quick_random:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_quick_random:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_quick_random:0:0,'</td>');
    writeln(resultado,'<td bgcolor=yellow>',tempo[i+1].tempo_quick_intro:0:8,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].compara_quick_intro:0:0,'</td>'
      +'<td bgcolor=orange>',tempo[i+1].troca_quick_intro:0:0,'</td></tr>');
    writeln('PRONTO!');
    write(resultadoR,n[i],' ');
    write(resultadoR,tempo[i+1].tempo_bubble:0:8,' ',tempo[i+1].compara_bubble,' ',tempo[i+1].troca_bubble,' ');
    write(resultadoR,tempo[i+1].tempo_selection:0:8,' ',tempo[i+1].compara_selection,' ',tempo[i+1].troca_selection,' ');
    write(resultadoR,tempo[i+1].tempo_inserction:0:8,' ',tempo[i+1].compara_inserction,' ',tempo[i+1].troca_inserction,' ');
    write(resultadoR,tempo[i+1].tempo_shell:0:8,' ',tempo[i+1].compara_shell,' ',tempo[i+1].troca_shell,' ');
    write(resultadoR,tempo[i+1].tempo_heap:0:8,' ',tempo[i+1].compara_heap,' ',tempo[i+1].troca_heap,' ');
    write(resultadoR,tempo[i+1].tempo_quick_inicio:0:8,' ',tempo[i+1].compara_quick_inicio,' ',tempo[i+1].troca_quick_inicio,' ');
    write(resultadoR,tempo[i+1].tempo_quick_meio:0:8,' ',tempo[i+1].compara_quick_meio,' ',tempo[i+1].troca_quick_meio,' ');
    write(resultadoR,tempo[i+1].tempo_quick_fim:0:8,' ',tempo[i+1].compara_quick_fim,' ',tempo[i+1].troca_quick_fim,' ');
    write(resultadoR,tempo[i+1].tempo_quick_random:0:8,' ',tempo[i+1].compara_quick_random,' ',tempo[i+1].troca_quick_random,' ');
    write(resultadoR,tempo[i+1].tempo_quick_mediana:0:8,' ',tempo[i+1].compara_quick_mediana,' ',tempo[i+1].troca_quick_mediana,' ');
    writeln(resultadoR,tempo[i+1].tempo_quick_intro:0:8,' ',tempo[i+1].compara_quick_intro,' ',tempo[i+1].troca_quick_intro,' ');
  end;
  writeln('Pressione enter para sair...');
  write(resultado,'</table></html>');
  close(resultado);
  close(resultadoR);
  readln;
end.
