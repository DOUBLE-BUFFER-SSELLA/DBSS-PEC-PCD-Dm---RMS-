% **************************************************************
% Cálculo da Discrepância Média (Dm) e Erro Médio Quadrático (RMS)
% utilizando o método do Buffer Duplo para múltiplas feições
% **************************************************************

% Limpar o ambiente de trabalho e fechar figuras abertas
clear all; close all; clc;

% ---------------------------
% PARÂMETROS INICIAIS
% ---------------------------

% Largura do buffer (X) em metros
X = 7;

% Definir manualmente os dados das feições
lg_nome = {'HISAJI MORITA','JEAN MURAT','DIEGO FIGUEIROA','SERRA PANATI','PEDRO MADEIRA','SUGAYA','SALAMANCA','CONSTANTINO FERNANDES','JARAGUA SUL','VIRGINIA FERNI','NAGIB MALUF','ANGELICA RAZZI'};
area_AF = [2397.104, 24.262, 97.310, 111.324, 5.841, 2399.219, 231.982, 95.602, 309.555, 397.371, 2365.225, 4.409]; % Áreas correspondentes às feições (AF)
area_AT = [14047.897, 876.887, 4256.972, 4970.071, 1022.382, 45180.166, 12579.871, 3036.626, 6461.290, 12736.671, 50214.600, 2567.792]; % Áreas de referência correspondentes (AT)

% Número de feições
n = length(lg_nome);

% Verificação de consistência dos dados
if length(area_AF) ~= n || length(area_AT) ~= n
    error('O número de entradas em lg_nome, area_AF e area_AT deve ser igual.');
end

% ---------------------------
% CÁLCULO DA DISCREPÂNCIA MÉDIA (Dm)
% ---------------------------

Dm_values = zeros(1, n); % Vetor para armazenar Dm de cada feição

for i = 1:n
    % Cálculo da Discrepância Média para cada feição
    Dm_values(i) = pi * X * (area_AF(i) / area_AT(i));
end

% Somatória das discrepâncias
soma_discrepancias = sum(Dm_values);

% Média das discrepâncias
media_discrepancias = mean(Dm_values);

% ---------------------------
% CÁLCULO DO ERRO MÉDIO QUADRÁTICO (RMS)
% ---------------------------

RMS = sqrt(sum(Dm_values .^ 2) / n);

% ---------------------------
% EXIBIÇÃO DOS RESULTADOS
% ---------------------------

% Exibir tabela com resultados
fprintf('-----------------------------------------\n');
fprintf(' DOUBLE_BUFFER_SSELLA:\n');
fprintf('-----------------------------------------\n');
fprintf(' Resultados do Calculo de Dm e RMS:\n');
fprintf('-----------------------------------------\n');
fprintf('-----------------------------------------\n');
fprintf(' Feicao\t\t\tDm\n');
fprintf('-----------------------------------------\n');
for i = 1:n
    fprintf(' %-20s\t%.6f\n', lg_nome{i}, Dm_values(i));
end
fprintf('-----------------------------------------\n');
fprintf('-----------------------------------------\n');
fprintf(' Somatoria das Discrepancias: %.6f\n', soma_discrepancias);
fprintf(' Media das Discrepancias: %.6f\n', media_discrepancias);
fprintf(' Erro Medio Quadratico (RMS): %.6f\n', RMS);
fprintf('-----------------------------------------\n');

% ---------------------------
% PLOTAGEM DOS RESULTADOS
% ---------------------------

figure;
bar(Dm_values);
hold on;
plot([0 n+1], [media_discrepancias media_discrepancias], 'r--', 'LineWidth', 2); % Linha da média Dm
set(gca, 'XTickLabel', lg_nome, 'XTick', 1:n);
xlabel('Feicoes');
ylabel('Discrepancia Media (Dm)');
title('Discrepancia Media por Feicao (m)');
legend('Dm por Feicao', 'Media das Discrepancias');
grid on;
rotateXLabels(gca, 45); % Rotacionar labels do eixo X para melhor visualização
hold off;

% ---------------------------
% SALVAR RESULTADOS
% ---------------------------

% Criar uma tabela com os resultados
resultados = table(lg_nome', area_AF', area_AT', Dm_values', 'VariableNames', {'Feicao', 'Area_AF', 'Area_AT', 'Dm'});

% Salvar tabela em um arquivo CSV
writetable(resultados, 'resultados_dm_rms.csv');

% **************************************************************
% FIM DO CÓDIGO
% **************************************************************

