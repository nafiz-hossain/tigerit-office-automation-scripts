#changelog: 1.0.1
#Improved extraction of message ID, Topic, and sender ID from log lines, by using a single regex pattern to match all three values.
#Refactored data structure for storing duplicate payloads using a nested defaultdict.
#Improved handling of payload types by checking if the payload type is in a predefined list ('delivered', 'read', 'ginbox', 'inbox').
#Adjustments in the main function to accommodate the new data structure and payload type checks

import os
import re
from collections import defaultdict



# Function to extract message ID, Topics, and sender ID from a log line
def extract_info(line):
    # Match the message ID
    match_message_id = re.search(r'"messageId":"([^"]+)"', line)
    match_sender_id = re.search(r'"from":"([^"]+)"', line)
    topic_match = re.search(r'communicator\/\d+\/[a-zA-Z0-9-]+\/([a-zA-Z0-9-]+)', line)

    if match_message_id and match_sender_id and topic_match:
        message_id = match_message_id.group(1)
        sender_id = match_sender_id.group(1)
        topic = topic_match.group(1)

        #print("message_id, sender_id:, topic: ", message_id, sender_id, topic)
    
        return message_id, topic, sender_id
    else:
        #print("No match_message_id and match_sender_id and topic_match:", line)
        return None, None, None
def extract_info_inbox(line):
    # Match the message ID
    match_message_id = re.search(r'\"messageId\":\"([^\"]+)\"', line)
    match_sender_id = re.search(r'\"from\":\"([^\"]+)\"', line)

    if match_message_id and match_sender_id:
        message_id = match_message_id.group(1)
        sender_id = match_sender_id.group(1)
        topic = 'inbox'

        #print("message_id, sender_id:, topic: ", message_id, sender_id, topic)
    
        return message_id, topic, sender_id
    else:
        #print("No match_message_id and match_sender_id and topic_match:", line)
        return None, None, None

# Function to process a log file and update the duplicate payloads dictionary
def process_log_file(file_path, duplicate_payloads):
    with open(file_path, 'r') as file:
        for line in file:

            if "PayloadProcessorService" in line and "Message stored in db" not in line:
                if "PayloadProcessorService: Inbox payload" in line:
                    message_id, topic, sender_id = extract_info_inbox(line)
                else:
                    message_id, topic, sender_id = extract_info(line)
                #print("message_id, topic, sender_id:", message_id, topic, sender_id)
                
                if message_id and topic and sender_id:
                    key = (message_id, topic, sender_id)
         
                    if key not in duplicate_payloads:
                        duplicate_payloads[key] = {'delivered': [], 'read': [], 'ginbox': [], 'inbox': []}
                    if topic in ('delivered', 'read', 'ginbox', 'inbox'):
                        #print(f"Found payload type: {topic}")
                        duplicate_payloads[key][topic].append(line.strip())

# Main function
def main(folder_path):
    duplicate_payloads = defaultdict(dict)
    for file_name in os.listdir(folder_path):
        if file_name.endswith(".log"):
            file_path = os.path.join(folder_path, file_name)
            print("Processing file:", file_path)
            process_log_file(file_path, duplicate_payloads)
            

    # Create 'duplicates' folder if it doesn't exist
    duplicates_folder = os.path.join(folder_path, 'duplicates')
    if not os.path.exists(duplicates_folder):
        os.makedirs(duplicates_folder)

    # Save duplicates to corresponding files in 'duplicates' folder

    for message_id, topic, sender_id in duplicate_payloads.keys():
        for payload_type, lines in duplicate_payloads[(message_id, topic, sender_id)].items():
            if len(lines) > 1:
                file_name = f"duplicate_{message_id}_{payload_type}_{sender_id}.log"
                file_path = os.path.join(duplicates_folder, file_name)
                with open(file_path, 'w') as dup_file:
                    for line in lines:
                        dup_file.write(line + '\n')
                print(f"Duplicate Payload Found. Saved to {file_path}")


# Example usage
if __name__ == "__main__":
    folder_path = "/home/nafiz/.config/commchat-agent/logs"  # Your folder path
    main(folder_path)
