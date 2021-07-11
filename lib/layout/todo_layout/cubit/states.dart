abstract class TodoStates {}

class TodoInitialState extends TodoStates {}

class TodoSetBottomNavigationState extends TodoStates {}

class TodoDatabaseCreated extends TodoStates {}

class TodoInsertIntoDatabase extends TodoStates {}

class TodoUpdateFromDatabase extends TodoStates {}

class TodoDeleteFromDatabase extends TodoStates {}

class TodoGetTaskListFromDatabase extends TodoStates {}

class TodoBottomSheetVisibilityState extends TodoStates {}
