get_git_info() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
        # # 計算 Git 狀態
        # local staged=$(git diff --cached --name-only 2>/dev/null | wc -l)  # 已 staged
        # local unstaged=$(git diff --name-only 2>/dev/null | wc -l)  # 未提交
        # local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)  # 未跟蹤檔案
        
        # local total_changes=$((staged + unstaged + untracked))
        
        # 分支名放在括號內，變更狀態放在括號外
        local git_display=" \[\033[36m\]($branch)\[\033[0m\]"
        
        # if [[ "$total_changes" -gt 0 ]]; then
        #     git_display+="\[\033[32m\]±$total_changes\[\033[0m\]"
        # fi
        
        echo -n "$git_display"
    fi
}

update_prompt() {
    # # 使用 $SECONDS 記錄開始和結束時間，避免日期命令計算的問題
    # local current_seconds=$SECONDS
    
    # if [[ -n "$LAST_COMMAND_START_SECONDS" ]]; then
    #     # 計算秒數（整數）並轉換為浮點數字符串
    #     local elapsed=$(( current_seconds - LAST_COMMAND_START_SECONDS ))
    #     local duration=$(printf "%.2f" $elapsed)
    # else
    #     local duration="0.00"
    # fi
    
    # 使用較小的灰色字體為時間戳和執行時間
    local dim_color="\[\033[90m\]"
    local reset="\[\033[0m\]"
    
    # 取得當前時間
    local timestamp="${dim_color}$(date +%H:%M)${reset}"
    
    # 取得 Git 分支與狀態
    local username="\[\033[32m\]\u${reset}"
    local at="\[\033[32m\]@${reset}"
    local hostname="\[\033[32m\]\h${reset}"
    local cwd="\[\033[33m\]\w${reset}"
    local git_info="$(get_git_info)"
    
    # 設定 Prompt
    PS1="${timestamp} ${username}${at}${hostname} ${cwd}${git_info}"
    
    # # 顯示執行時間 (排除空命令和極短時間)
    # if [[ $elapsed -gt 0 ]]; then
    #     PS1+="  ${dim_color}${duration}s${reset}"
    # fi
    
    PS1+="\n\$ "
    
    # 記錄這次命令的開始時間
    # LAST_COMMAND_START_SECONDS=$SECONDS
}

PROMPT_COMMAND=update_prompt