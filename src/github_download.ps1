# GitHub API 엔드포인트 및 사용자 정보 설정
function downRepositories {
    param (
        [String]$githubUser, 
        [int]$pageCount        
    )

    $githubApiUrl = "https://api.github.com/users/$githubUser/repos?page=$pageCount"
    $headers = @{
        "Accept" = "application/vnd.github.v3+json"
    }

    # GitHub API를 통해 레포지토리 리스트 가져오기
    $reposResponse = Invoke-RestMethod -Uri $githubApiUrl -Headers $headers

    if ($reposResponse.count -lt 1){
        return $False
    } 

    # 각 레포지토리에서 zip 다운로드 링크 추출 및 다운로드
    foreach ($repo in $reposResponse) {
        $repoName = $repo.name
        $zipUrl = "https://github.com/$githubUser/$repoName/archive/refs/heads/master.zip"
        $outputPath = "$pwd\$repoName.zip"

        # zip 파일 다운로드
        Invoke-WebRequest -Uri $zipUrl -OutFile $outputPath

        Write-Host "다음 링크에서 다운로드 완료: $zipUrl"
        Write-Host "저장된 경로: $outputPath"
    }

    return $True
    
}

$isnext = $False
$count = 1
$user = Read-Host "github 계정을 입력하세요:"
do{
    $isnext = downRepositories -githubUser $user -pageCount $count 
    $count = $count + 1
}while($isnext)