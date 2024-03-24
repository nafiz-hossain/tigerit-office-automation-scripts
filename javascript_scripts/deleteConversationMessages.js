//To remove all records in the messages table where conversationRefId matches "360f2c1f-dc9b-4e86-8d88-af630d6f782a" -


// Open IndexedDB database
var request = indexedDB.open('CommChatDB');

request.onsuccess = function(event) {
    var db = event.target.result;
    
    // Start a transaction on the messages object store
    var transaction = db.transaction(['messages'], 'readwrite');
    var objectStore = transaction.objectStore('messages');
    
    // Open a cursor to traverse all records in the object store
    var cursorRequest = objectStore.openCursor();
    
    cursorRequest.onsuccess = function(event) {
        var cursor = event.target.result;
        
        // Check if there are records to iterate over
        if (cursor) {
            var record = cursor.value;
            
            // Check if the conversationRefId matches the target value
            if (record.conversationRefId === '360f2c1f-dc9b-4e86-8d88-af630d6f782a') {
                // Delete the record from the object store
                var deleteRequest = cursor.delete();
                
                deleteRequest.onsuccess = function(event) {
                    console.log('Record deleted successfully');
                };
                
                deleteRequest.onerror = function(event) {
                    console.error('Error deleting record:', event.target.error);
                };
            }
            
            // Move to the next record
            cursor.continue();
        } else {
            console.log('Finished iterating over records');
        }
    };
    
    cursorRequest.onerror = function(event) {
        console.error('Error opening cursor:', event.target.error);
    };
};