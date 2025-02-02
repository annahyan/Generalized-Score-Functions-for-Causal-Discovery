% Learning the causal structure with generalized score-based method and with GES search
% The score function can be negative cross-validated log-likelihood or marginal log-likelihood with regression in RKHS
% example 1
clear all,clc,close all

addpath(genpath(pwd))
load example_data


melanoma_mat = dlmread("/home/anna/ClusterProjects/mutsigints/data/test/GES_test_melanoma_sig_pathways.tsv", "\t", 1, 0);

%% X=X-repmat(mean(X),size(X,1),1);
%% X=X*diag(1./std(X));

% X=X(:, 1:4);

maxP = 5; % maximum number of parents when searching the graph
parameters.kfold = 10; % 10 fold cross validation
parameters.lambda = 0.01;
multi_sign = 0;
Record = GES(melanoma_mat,1,multi_sign,maxP,parameters);

%function [Record] = GES(X,score_type,multi_sign,maxP,parameters)
% INPUT:
% X: Data with T*D dimensions
% score_type: the score function you want to use
%               score_type = 1: cross-validated likelihood
%               score_type = 2: marginal likelihood
% multi_sign: 1: if are multi-dimensional variables; 0: otherwise
% maxP: allowed maximum number of parents when searching the graph
% parameters: when using CV likelihood, 
%               parameters.kfold: k-fold cross validation
%               parameters.lambda: regularization parameter

% OUTPUT:
% Record.G: learned causal graph
%        G(i,j) = 1: i->j (the edge is from i to j)
%        G(i,j) = -1: i-j (the direction between i and j is not determined)
%        G(i,j) = 0:  i j (no causal edge between i and j)
% Record.update1: each update (Insert operator) in the forward step
% Record.update2: each update (Delete operator) in the backward step
% Record.G_step1: learned graph at each step in the forward step
% Record.G_step2: learned graph at each step in the backward step
% Record.score: the score of the learned graph
