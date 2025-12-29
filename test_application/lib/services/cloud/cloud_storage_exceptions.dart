class CloudStorageException implements Exception{
  const CloudStorageException();
}

class CouldNotCreateNoteExceptions extends CloudStorageException{}//C
class CouldNotGetAllNotesExceptions extends CloudStorageException{}//R
class CouldNotUpdateNoteExceptions extends CloudStorageException{}//U
class CouldNotDeleteNoteExceptions extends CloudStorageException{}//D