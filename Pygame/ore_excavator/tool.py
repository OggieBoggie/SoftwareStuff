from pygame import *


class Tool:
    '''Constructor for tool class, has three atrributes
    the name describes the name of the tool. The description
    gives a description of the tool for the shop menu. The price indicates
    the amount required to purchase the tool and income is the amount
    of ores generated by the tools. There is an additional attribute called 
    amount which describes the amount of the current tool.'''

    def __init__(self, name, description, price=10, income=1/10):
        self.name = name
        self.description = description
        self.price = max(price, 1)
        self.income = income
        self.amount = 0

    def purchase_tools(self, score):
        '''A method allowing users to purchase tools, it will take the score
        class as an agrument, checking if the player has enough points to buy
        the tool. If the player does not have enough points, do nothing. If the player
        has enough points, call the subtract method from the score class and add the tool, 
        increasing the price of the tool by 15%'''
        if score.points >= self.price:
            score.subtract_score(self.price)
            self.amount += 1
            self.price = round(self.price * 1.15)
        else:
            print('Not enough points. ')


def calculate_ops(tools):
    '''Takes a list as an argument, goes through the list adding
    all the income from each tool calculating the ores per second
    and return the total rounded to one decimal place. '''
    total = 0
    for tool in tools:
        total += tool.income * tool.amount
    return round(total, 1)


# declaring tools
pickaxes = Tool('Auto-Pickaxe', 'Mines ores for the user. ')
minecart = Tool('Minecarts', 'Allows ore transportation. ', 100, 1)
creeper = Tool('Creeper', 'Aw man', 1100, 8)
drill = Tool('Drill Unit', 'Flying drill that mines ores with lasers. ', 12000, 47)
excavator = Tool('Ore Excavator', 'Excavates lots of ores. ', 130000, 260)
nano = Tool('Nanomachines', 'They harden against physical trauma. ', 1400000, 1400)
java = Tool('JS Console', 'Add ores via the console interface. ', 30000000, 20000)

# creating list for tool
tool_list = [pickaxes, minecart, creeper, drill, excavator, nano, java]

# specified buttons for tools
buy_pickaxe = Rect(275, 130, 200, 40)
buy_minecart = Rect(275, 180, 200, 40)
buy_creeper = Rect(275, 230, 200, 40)
buy_drill = Rect(275, 280, 200, 40)
buy_excavator = Rect(275, 330, 200, 40)
buy_nano = Rect(275, 380, 200, 40)
buy_java = Rect(275, 430, 200, 40)

# shop buttons for specified tool
tool_buttons = [buy_pickaxe, buy_minecart, buy_creeper, buy_drill, buy_excavator, buy_nano, buy_java]