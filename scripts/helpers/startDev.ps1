
$sessionName = "dev"

function Open-Session {
    if ($env:TMUX) {
        tmux switch-client -t $sessionName
    }
    else {
        tmux attach-session -t $sessionName
    }
}

# Check if session already exists
tmux has-session -t $sessionName 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Output "Session '$sessionName' already exists. Attaching..."
    Open-Session
    return
}

# Create new session with opencode running in the left pane.
tmux new-session -d -s $sessionName -n "dev" -c "/home/joshua" "opencode web --port 4096"

# Split window horizontally for side by side and start the local app.
tmux split-window -h -t "$sessionName:0" -c "/home/joshua/code/work/llm-usage" "yarn start:local"
tmux select-layout -t "$sessionName:0" even-horizontal

Open-Session
