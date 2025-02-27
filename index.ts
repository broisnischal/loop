

enum Status {
  pending = 'pending',
  completed = 'completed',
  skipped = 'skipped',
}

enum TaskType {
  task = 'task',
  goal = 'goal',
  todo = 'todo',
}


interface User {
  id: string;
  name: string;
  email: string;
  tags: Tag[];

  activity: UserActivity;
}

interface UserActivity {
  id: string;
  lastLogin: string;
}

interface Tag {
  id: string;
  name: string;
}

interface Task {
  id: string;
  emoji: string;
  title: string;
  description: string;
  status: Status;
  toRemind: boolean;

  user: User;
  tags: Tag[]; // User's tags

  startTime: string;
  endTime: string;
  date: string | undefined; // undefined when it's a recurring task

  taskType: TaskType;
  repeat: Repeat;

  taskPerf: TaskPerf;
}


interface TaskPerf {
  id: string;
  remind: boolean;
  alarm: boolean;
  muted: boolean;
  snooze: boolean;
  snoozeDuration: boolean;
  repeat: boolean;
  repeatDuration: boolean;
  repeatInterval: boolean;

  color: string;
}

enum Repeat {
  daily = 'daily',
  monthly = 'monthly',
  once = 'once',
}