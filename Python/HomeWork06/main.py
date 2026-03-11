import task02
import task03

if __name__ == '__main__':
    tasks = {
        "2": task02.run,
        "3": task03.run,
    }
    tasks_nums = list(tasks.keys())
    while True:
        task_num = input(f"Select task to execute {tasks_nums} or 0 to finish: ")

        if task_num == "0" or not task_num:
            break

        if task_num in tasks:
            tasks[task_num]()
            print()
        else:
            print(f"Invalid task. Select from {tasks_nums}.")