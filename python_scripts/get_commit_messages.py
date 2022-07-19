import subprocess
import sys

def update_repo(repo_path):
    try:
        subprocess.run(["git", "pull"], cwd=repo_path, check=True)
        return True
    except Exception as e:
        print(f"Failed to update repository: {e}")
        return False

def get_commit_messages(repo_path, starting_commit_id):
    commit_messages = []
    try:
        result = subprocess.run(["git", "log", "--format=%s", f"{starting_commit_id}..HEAD"], cwd=repo_path, capture_output=True, text=True)
        if result.returncode == 0:
            commit_messages = result.stdout.splitlines()
            # Filter out commit messages starting with 'merge' (case insensitive)
            commit_messages = [message for message in commit_messages if not message.lower().startswith('merge')]
        else:
            print("Failed to retrieve commit data.")
    except Exception as e:
        print(f"Error: {e}")
    return commit_messages

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <repository_path> <starting_commit_id>")
        sys.exit(1)
    
    repo_path = sys.argv[1]
    starting_commit_id = sys.argv[2]
    
    # Update the local repository
    if update_repo(repo_path):
        print("Repository updated successfully.")
    else:
        print("Failed to update repository. Exiting.")
        sys.exit(1)
    
    # Retrieve commit messages
    commit_messages = get_commit_messages(repo_path, starting_commit_id)
    if commit_messages:
        print("\n".join(commit_messages))
    else:
        print("No commit messages found.")
