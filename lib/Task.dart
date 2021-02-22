class Task {
  String task;
  bool done;

  Task(this.task, this.done);

  @override
  String toString() {
    return '{ ${this.task}, ${this.done} }';
  }
}
