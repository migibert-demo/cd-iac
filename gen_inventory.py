import sys

def main():
    with open('ansible/inventory', 'w') as inventory:
        for line in sys.stdin:
            splitted_line = line.split(': ')
            key = splitted_line[0]
            values = splitted_line[1]
            data = '[%s]\n%s\n'%(key, values.replace(',', '\n'))
            inventory.write(data)
    
main()
        