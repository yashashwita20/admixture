# Neural-Admixture vs ADMIXTURE for Global Ancestry Analysis

A comparison between ADMIXTURE program and a new neural network-based approach for determining global ancestry compositions.

## Models Tested

- ADMIXTURE program (By Alexander et al)
- Neural-Admixture (By Mantes et al)

## Analysis Report
You can find detailed analysis of the models and plots in the the jupyter notebook.

## Steps to Run
(Recommended to run on Datahub instance of CSE 284 because ADMIXTURE program is already installed. If you want to run it locally first install ADMIXTURE for your system from here - https://dalexander.github.io/admixture/download.html).

On your datahub instance - open terminal and run the following commands to install neural-admixture:
```shell
pip install neural-admixture
pip install --upgrade numpy numba numexpr
```
Now git clone this repository (contains example data file to create plots)
```shell
git clone https://github.com/yashashwita20/admixture.git
```
## Work left

1. Memory benchmark
2. Find out why Neural-Admixture is faster locally than on Datahub
3. More detailed Model/Output explanations
