GB comments;
Prob1: 100%
Prob2:
P1:100
P2: 100
P3:100
P4:100
P5:100 
Prob3
P1: 100
P2:100
P3:50  Graph is produced incorrectly as a line graph. Should be a bar graph. xticks and xticklables are not variables. Need to xticks = ([1 2 3 4 5])
xticklabels = ({'B','C','D','E','F'}) for it to work. 
Overall: 94


% Homework 1. Due before class on 9/5/17

%% Problem 1 - addition with strings

% Fill in the blank space in this section with code that will add 
% the two numbers regardless of variable type. Hint see the matlab
% functions ischar, isnumeric, and str2num. 

%your code should work no matter which of these lines is uncommented. 
%x = 3; y = 5; % integers
%x = '3'; y= '5'; %strings
 x = 3; y = '5'; %mixed

%your code goes here
if ischar(x) == 1
    a = str2num(x);
else a = x
end
if ischar(y) == 1
    b = str2num(y);
else b = y
end

z = a + b;

%output your answer
z;
% z = 8
%% Problem 2 - our first real biology problem. Open reading frames and nested loops.

%part 1: write a piece of code that creates a random DNA sequence of length
% N (i.e. consisting of the letters ATGC) where we will start with N=500 base pairs (b.p.).
% store the output in a variable
% called rand_seq. Hint: the function randi may be useful. 
% Even if you have access to the bioinformatics toolbox, 
% do not use the builtin function randseq for this part. 

N = 500; % define sequence length
rand_seq = randi(4, 1, N);
rand_seq = num2str(rand_seq);
rand_seq=rand_seq(rand_seq~=' ');
for jj=1:N
    if rand_seq(jj) == '1'
        rand_seq(jj) = char('A');
    elseif rand_seq(jj) == '2'
        rand_seq(jj) = char('T');
    elseif rand_seq(jj) == '3'
        rand_seq(jj) = char('G');
    else
        rand_seq(jj) = char('C');
    end
end

%part 2: open reading frames (ORFs) are pieces of DNA that can be
% transcribed and translated. They start with a start codon (ATG) and end with a
% stop codon (TAA, TGA, or TAG). Write a piece of code that finds the longest ORF 
% in your seqeunce rand_seq. Hint: see the function strfind.

start_codon = strfind(rand_seq, 'ATG');
l = [];
for i = 1:length(start_codon)
    n = start_codon(i);
    m = n + 3;
    stop_codon = ["TAA", "TGA", 'TAG'];
    if m + 2 < N
        while contains(stop_codon, char(rand_seq(m:m+2))) == 0
            m = m + 3;
            if m + 2 > N
                m = n;
                break
            end

        end
    else
        m = n;
    end
    l(i) = m - n;
end

[M, I] = max(l);
longest_ORF = rand_seq(start_codon(I):start_codon(I)+M+2)

%part 3: copy your code in parts 1 and 2 but place it inside a loop that
% runs 1000 times. Use this to determine the probability
% that an sequence of length 500 has an ORF of greater than 50 b.p.

p = 0;
for ii = 1: 1000    
    N = 500; % define sequence length
    rand_seq = randi(4, 1, N);
    rand_seq = num2str(rand_seq);
    rand_seq=rand_seq(rand_seq~=' ');
    for jj=1:N
        if rand_seq(jj) == '1'
            rand_seq(jj) = char('A');
        elseif rand_seq(jj) == '2'
            rand_seq(jj) = char('T');
        elseif rand_seq(jj) == '3'
            rand_seq(jj) = char('G');
        else
            rand_seq(jj) = char('C');
        end
    end

    start_codon = strfind(rand_seq, 'ATG');
    l = [];

    for i = 1:length(start_codon)
        n = start_codon(i);
        m = n + 3;
        stop_codon = ['TAA', 'TGA', 'TAG'];
        if m + 2 < N
            while contains(stop_codon, char(rand_seq(m:m+2))) == 0
                m = m + 3;
                if m + 2 > N
                    m = n;
                    break
                end
            end
        else
            m = n;
        end
        l(i) = m - n;
    end
    [M, I] = max(l);
    if M + 2 > 50
        p = p + 1;
    end
end
probability = p ./ 1000;

    


%part 4: copy your code from part 3 but put it inside yet another loop,
% this time over the sequence length N. Plot the probability of having an
% ORF > 50 b.p. as a funciton of the sequence length. 

for N = 1:500 
    p = 0;
    for ii = 1: 1000    
        rand_seq = randi(4, 1, N);
        rand_seq = num2str(rand_seq);
        rand_seq=rand_seq(rand_seq~=' ');
        for jj=1:N
            if rand_seq(jj) == '1'
                rand_seq(jj) = char('A');
            elseif rand_seq(jj) == '2'
                rand_seq(jj) = char('T');
            elseif rand_seq(jj) == '3'
                rand_seq(jj) = char('G');
            else
                rand_seq(jj) = char('C');
            end
        end

        start_codon = strfind(rand_seq, 'ATG');
        l = [];

        for i = 1:length(start_codon)
            n = start_codon(i);
            m = n + 3;
            stop_codon = ['TAA', 'TGA', 'TAG'];
            if m + 2 < N
                while contains(stop_codon, char(rand_seq(m:m+2))) == 0
                    m = m + 3;
                    if m + 2 > N
                        m = n;
                        break
                    end
                end
            else
                m = n;
            end
            l(i) = m - n;
        end
        [M, I] = max(l);
        if M + 2 > 50
            p = p + 1;
        end
    end
    sequence_length(N) = N;
    prob(N) = p ./ 1000;
end

figure;
plot(sequence_length, prob, 'b-', 'LineWidth', 3);
xlabel('sequence length(b.p.)', 'FontSize', 24);
ylabel('Probability to have an ORF greater than 50 b.p.', 'FontSize', 24);
set(gca,'FontSize', 16);

%part 5: Make sure your results from part 4 are sensible. What features
% must this curve have (hint: what should be the value when N is small or when
% N is very large? how should the curve change in between?) Make sure your
% plot looks like this. 

% Answer: There should not be any chance for random sequence with less than
% 50 b.p. to have a 50bp greater ORF. The more base pairs a dna sequence
% contains, the more likely it is to have a 50 bp greater ORF.


%% problem 3 data input/output and simple analysis

%The file qPCRdata.txt is an actual file that comes from a Roche
%LightCycler qPCR machine. The important columns are the Cp which tells
%you the cycle of amplification and the position which tells you the well
%from the 96 well plate. Each column of the plate has a different gene and
%each row has a different condition. Each gene in done in triplicates so
%columns 1-3 are the same gene, columns 4-6 the same, etc.
%so A1-A3 are gene 1 condition 1, B1-B3 gene 1 condition 2, A4-A6 gene 2
%condition 1, B4-B6 gene2 condition 2 etc. 

% part1: write code to read the Cp data from this file into a vector. You can ignore the last two
% rows with positions beginning with G and H as there were no samples here. 

clear all
filename = 'qPCRdata.txt';
fid = fopen(filename, 'r');
A = fscanf(fid, '%s\n');
lines = strsplit(A, 'True255');
lines(1) = [];
B = [];
for ii = 1:72
    if ii < 10
        b = char(lines(ii));
        B(ii) = str2num(b(10:14));
    elseif ii <13
        b = char(lines(ii));
        B(ii) = str2num(b(11:15));
    else
        ind = strfind(lines(ii), num2str(ii))
        b = char(lines(ii))
        ind = cell2mat(ind)
        m = ind(1) + 2
        n = ind(1) + 6
        B(ii) = str2num(b(m:n))
    end
end


% Part 2: transform this vector into an array representing the layout of
% the plate. e.g. a 6 row, 12 column array should that data(1,1) = Cp from
% A1, data(1,2) = Cp from A2, data(2,1) = Cp from B1 etc. 

data = zeros(6, 12);
for i = 1:6
    for j = 1:12
        data(i,j) = B (12 * (i-1) + j)
    end
end


% Part 3. The 4th gene in columns 10 - 12 is known as a normalization gene.
% That is, it's should not change between conditions and it is used to normalize 
% the expression values for the others. For the other three
% genes, compute their normalized expression in all  conditions, normalized to condition 1. 
% In other words, the fold change between these conditions and condition 1. The
% formula for this is 2^[Cp0 - CpX - (CpN0 - CpNX)] where Cp0 is the Cp for
% the gene in the 1st condition, CpX is the value of Cp in condition X and
% CpN0 and CpNX are the same quantitites for the normalization gene.
% Plot this data in an appropriate way. 

GeneN = sum(data(:,10:12),2)./3;
Gene1 = sum(data(:, 1:3),2)./3;
Gene2 = sum(data(:, 4:6),2)./3;
Gene3 = sum(data(:, 7:9),2)./3;
y1 = zeros(1,5)
y2 = zeros(1,5)
y3 = zeros(1,5)
for p = 1:5
    q = p + 1;
    y1(p) = 2^[GeneN(q)-Gene1(q)-(GeneN(1)-Gene1(1))];
    y2(p) = 2^[GeneN(q)-Gene2(q)-(GeneN(1)-Gene2(1))];
    y3(p) = 2^[GeneN(q)-Gene3(q)-(GeneN(1)-Gene3(1))];
end

figure;
xticks([1 2 3 4 5])
xticklabels({'B','C','D','E','F'})
hold on;

plot(y1, 'y-', 'LineWidth', 3);
plot(y2, 'g-', 'LineWidth', 3);
plot(y3, 'b-', 'LineWidth', 3);
xlabel('Conditions', 'FontSize', 24);
ylabel('Expression values', 'FontSize', 24);
legend({'Gene1', 'Gene2', 'Gene3'}, 'FontSize', 18);
set(gca, 'FontSize', 16);

%% Challenge problems that extend the above (optional)

% 1. Write a solution to Problem 2 part 2 that doesn't use any loops at
% all. Hint: start by using the built in function bsxfun to make a matrix of all distances
% between start and stop codons. 

% 2. Problem 2, part 4. Use Matlab to compute the exact solution to this
% problem and compare your answer to what you got previously by testing
% many sequences. Plot both on the same set of axes. Hint: to get started 
% think about the following:
% A. How many sequences of length N are there?
% B. How many ways of making an ORF of length N_ORF are there?
% C. For each N_ORF how many ways of position this reading frame in a
% sequence of length N are there?

% 3. Problem 3. Assume that the error in each Cp is the standard deviation
% of the three measurements. Add a section to your code that propogates this
% uncertainty to the final results. Add error bars to your plot. (on
% propagation of error, see, for example:
% https://en.wikipedia.org/wiki/Propagation_of_uncertainty


