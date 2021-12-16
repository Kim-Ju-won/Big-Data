# Big Data : R고 싶은 R 소스 코드
# 팀장 : 공세형
# 팀원 : 공세형, 김주원, 임혜지, 정경우, 주재완, 조수진 
# 2-Level AHP Analysis Code

# Part 1. Package Installation

## Using DevTools to install old version ofahp
install.packages("devtools")

## Install ahp, igraph to visualize ahp analysisrequire(devtools) 
install_version("ahp", version = "0.2.12", 
                repos = "http://cran.us.r-project.org")
install.packages("igraph")

## Using extrafont for using Korean fonts for MAC
install.packages("extrafont")

library(igraph)
library(ahp)
library(extrafont)

# UTF-8 Patch for MAC
Sys.setlocale("LC_ALL", "ko_KR.UTF-8")
options(encoding = 'UTF-8') 
Sys.setenv(LANG = "ko_KR.UTF-8")
localeToCharset()

#Load Font for R
font_import()

#Read YAML data 
ahp_data <- Load(file.choose())
ahp_data

# Visualize AHP Model(계층 모형 출력)
Visualize(ahp_data,
          criteriaNodesStyle = list(style ="filled,rounded",
                                   shape = "box",
                                   color = "black",
                                   fillcolor = "black",
                                   fcontrol ="black"),
          alternativeNodesStyle = list(style ="filled,rounded",
                                      shape = "box",
                                      color = "black",
                                      fillcolor = "brown",
                                      fcontrol ="black"))
# Calculate for Inconsistency
Calculate(ahp_data)

# Show Result of the AHP Model
Analyze(ahp_data)
AnalyzeTable(ahp_data)
