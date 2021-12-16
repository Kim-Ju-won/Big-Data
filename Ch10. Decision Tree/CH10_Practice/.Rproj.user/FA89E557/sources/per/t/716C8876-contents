#10.4 R을 이용한 의사결정나무 연습

Sys.setlocale("LC_ALL", "ko_KR.UTF-8")
options(encoding = 'UTF-8') 
Sys.setenv(LANG = "ko_KR.UTF-8")
localeToCharset()  

install.packages("extrafont")
library(extrafont)
font_import()

# 패키지ㅣ 설치 및 로딩
install.packages("C50")
library(C50)

# 학습데이터 작성 

pclass <- c(1,1,1,1,2,
            2,2,2,2,2)

gender <- c("M","M","M","F","M",
            "M","M","M","F","F")

survived <- c("Y", "Y", "Y", "Y", "N",
              "N", "N", "Y", "Y", "Y")

train_data <- data.frame("좌석등급"=pclass, 
                         "성별" =gender,
                         "생존여부"=survived,
                         stringsAsFactors = TRUE)

#gender <- factor(c("M","M","M","F","M","M","M","M","F","F")
#gender <- as.factor(gender)train_data

train_data

str(train_data)

# test data 작성 

pclass <- c(1,2,2)
gender <- c("F", "F", "M")

test_data <- data.frame("좌석등급"= pclass,
                        "성별" = gender,
                        stringsAsFactors = TRUE)

test_data

# 데이터 출력 
# 예측 변수 를 ~물결 표 . 표시
model <- C5.0( 생존여부 ~ . , data = train_data)
summary(model)

plot(model)

# 분류 
results <- predict(object=model, newdata = test_data)
results


# 10.5 예제 : 붓꽃 종의 분류와 예측

#패키지 설치 및 로딩

# 패키지 설치 및 로딩
# install packages("C50")
library(C50)

#파일 읽기 
iris
str(iris)
nrow(iris)

# 데이터 분리를 위한 색인
# 150개 중에서 80프로를 train data 로 test data 를 20퍼센트 를 활용
# 랜덤 샘플링 set.seed() <- 샘플링의 결과를 고정 시켜줌(숫자를 통해서)
set.seed(3598)
# 랜덤하게 뽑힌 인덱스를 저장
idx <- sample(1:nrow(iris), size = nrow(iris)*0.8)
idx

length(idx)

# 데이터 분리
train_data <- iris[idx,]
train_data

test_data <- iris[-idx,]
test_data

#GloablPruning 전체 트리를 보고 세세한 부분을 잘라 내겠어
# False는 하나하나를 보고 판단을 하겠다. 

# 얼마나 강하게 가지치기를 할 것인가 
# CF =1 을 세세한 가지를 살리자 

#(모형 1) 가지치기 없는 경우
# 하나하나 보고 결정을 할건데, 웬만한 가지는 살릴 거야 
c5_options <- C5.0Control(noGlobalPruning = T, CF = 1)
model1 <- C5.0(Species ~ ., data = train_data, control= c5_options)
summary(model1)

plot(model1)

#(모형 1) 지역적 가지치기
c5_options <- C5.0Control(noGlobalPruning = T, CF = 0.25)
model2 <- C5.0(Species ~ ., data = train_data, control= c5_options)
summary(model2)

plot(model2)

#(모형 1) 전역적 가지치기 
c5_options <- C5.0Control(noGlobalPruning = F, CF = 1)
model3 <- C5.0(Species ~ ., data = train_data, control= c5_options)
sammary(model3)# model 2와 동일한 결과

plot(model3)# model 1과 동일한 결과 

# 예측 
results <- predict(object = model1, newdata = test_data)
results 

# 예측 결과 검증 
table(results, test_data$Species)
