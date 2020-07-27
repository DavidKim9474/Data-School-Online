# 7월 29일

## 지옥에서 온 깃
*CRUD (Create, Read, Update, Delete)*

## Project Folder
* Stage Area
    * Git: git checks info inside stage area
        * Repository: Storage inside git (called 'commit' when info moves from stage to repository)
* Working Directory


## Terms
* 커밋: 워킹커피의 스냅샷
    * 커밋 아이디: 커밋한 내용에 대한 약 40기호의 식별 아이디
    * 새로운 커밋은 현재 해드가 가르키는 곳을 워킹커피로 삼는다
* 마스터: 마지막 버젼
    * 리셋: 사간 뒤로 돌려서 그 다음의 내용을 삭제 (마스터를 리셋한다)
    * git reset --hard
* 해드: 나의 워킹 커피가 어느 버젼에서 유래했는가
    * Detached Head: 해드가 마스터가 아닌 다른 곳을 가르키고 있다. 해드는 마스터가 아니다. 
* 체크아웃: 해드를 옮긴다, 시간 여행
* 버젼: 워킹커피를 수정한 내역의 스냅샷

## Command Lines (CL)
* CLI short for Command Line Interface: keyboard
    * As opposed to GUI (Graphic User Interface): mouse, 화면

## VSC
1. Open  an editor like VSC
2. ctrl + j 하면 terminal이 뜬다
    * 명령어를 태워서 컴퓨터에게 전달하는 terminal 
3. View의 Command Palette에서 Terminal: Select Default Shell > Git Bash
4. PWD: 나의 위치 확인 (directory)
5. 우선적으로 해드를 찾자 

## Command Line
* Git init
* Git status: present stage
* Git add index.html: add on stage
* Git commit -m "work 1": commit
* Git log: history
    * Git log --online: history 간략
* Git checkout [codenumber]: checks out to code position
* Git reflog: 노란색이 결과, 오른쪽이 했던 행위


# 7월 30일

## 팁
* 막힐 때는 Git Cheatsheet 알아보기

## Command Line
* mkdir [filename]: 새로운 파일 열기
* pwd: 내가 위치한 디렉토리 찾기
* cd [filename]: 현재 위치가 바뀐다
    * cd ..: 이 데릭테로의 부모 디렉토리로 올라간다. (격로는 현재 디렉토리에따라 상대적이다)
    * cd ../../..: 부모의 부모의 부모로 간다.
* rm -r [filename]: remove directory
    * rm -rf [filename]: remove directory forcefully (묻지말고 지워라)
* 옵션: -a, add
* -m: 메시지, "filename" 바로 앞에 와야한다
* file.gitignore: a file that saves other files you don't want committed as opensource
* reset: 해드가 가르키는 브렌치를 바꾸다

## Emulator
* git bash같은 체계들
* Window vs Unix(linux): 둘이 다른 체제를 가지고 있어 명령이 다르다. 에뮬레이터는 양쪽의 명령어가 서로에게 통할 수 있도록 '통역'을 해준다.

## Branch
* git branch [branchname]: branch 만들기
* git branch: branch 확인하기
* git checkout -b [branchname]: branch 만들고 바로 checkout하기 
* git branch -d [branchname]: branch 지우기

## Merge
* Base 바탕으로 두개의 버젼에서 베이스에서 변화한 것이 있는지 분석하고 변한 것 토대로 새로운 merge version을 만들어낸다.
* git merge --abort: 병합을 중간에 멈춰라
* git merge하고 conflict가 있을 경우, resolve를 시키고 저장한다음 commit 



# 7월 31일

## Gistory
* .index: file 이름 -누르면 수정 내역이 뜬다

반방향 암호: 단어를 긴 코드(sha1)으로 바꿀 수 있지만 그 반대로는 불가능하다.

## Command Line
* ls > [filename].txt: 새로운 파일 생성
* 무한반복으로 업데이트
```sh 
while true
do
curl -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like>  Gecko) Chrome/44.0.2403.89 Safari/537.36" https://datalab.naver.com/keyword/realtimeList.naver > naver.html
git commit -am "update naver"
sleep 5
done
```
* vi [filename].txt: 새로운 파일을 만든다.
    * i: 입력 모드
    * ctrl + c: 명령어 모드
        * : 을 누르면 입력 가능
        * w 을 누르면 저장
        * q 를 누르면 나간다

## Backup
* Make repository on GitHub
* git remote add origin [SSH_Address]
* git remote -v: check repository details
* git push --set-upstream: remote 저장소가 누군지를 세팅한다

## 비밀번호 세팅
1. ssh-keygen
2. Enter * 3
3. cd [저장주소]
4. ls -al
5. cat id_rsa.pub
    * pub: public
    * password has been created

## Command Line (협력)
* Pull = 불러내다
* Push = 저장하다
* Pull = Fetch + Merge