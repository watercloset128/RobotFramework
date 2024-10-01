import os
import re
import logging

from robot.api.deco import keyword, library
from RPA.Excel.Files import Files

@library(scope='SUITE', auto_keywords=True)
class UtilLibrary:
    
    @keyword(name='Get Test Data From Excel', types=[str, str, bool, int, bool])
    def get_test_data_from_excel(self, filename, sheetname, header=True, start=None, trim=True):
        '''
        Get table object for test data driven purpose
        '''

        if not os.path.exists(filename):
            filename = os.path.join(os.getcwd(), filename)
            if not os.path.exists(filename):
                raise FileNotFoundError

        excelreader = Files()
        excelreader.open_workbook(filename)

        try:
            return excelreader.read_worksheet_as_table(name=sheetname, header=header, trim=trim, start=start)
        
        except FileNotFoundError as e:
            logging.debug(e.with_traceback)

        finally:
            excelreader.close_workbook()

    @keyword(name='Get Data', types=[str])
    def getdata(self, temp):
        '''
        Robot Framework customized library function for tech validation
        '''
        if temp is not None:
            return True
        else:
            return False
        
    # @keyword(name='Convert Elementlocator To Tuple', types={'elementlocator': str})
    # def conver_elementlocator_to_tuple(self, elementlocator):
    #     '''
    #     Convert element locator from string to a tuple so that it could
    #     be used in Evaluate function and check the element condition with
    #     Wait For statement.

    #     Requirement: The elementlocator string must contain ':' (colon) or
    #                  '=' equal signs as the seperate symbol so that it could
    #                  be converted into a tuple
    #     '''
    #     if not (':' in elementlocator or '=' in elementlocator):
    #         return None
    #     elif (':' in elementlocator and '=' in elementlocator):
    #         return None
        
    #     patternstring = '[:|=]'
    #     locatorlist = re.split(patternstring, elementlocator)
    #     locatorlist = [x.strip() for x in locatorlist]
    #     return tuple(locatorlist)
    
    @keyword(name='Convert Elementlocator To Tuple String', types={'elementlocator': str})
    def conver_elementlocator_to_tuplestring(self, elementlocator):
        '''
        Convert element locator from string to a string like a tuple so that it could
        be used in Evaluate function and check the element condition with
        Wait For statement.

        Requirement: The elementlocator string must contain ':' (colon) or
                     '=' equal signs as the seperate symbol so that it could
                     be converted into a tuple string.
        '''
        if not (':' in elementlocator or '=' in elementlocator):
            return None
        elif (':' in elementlocator and '=' in elementlocator):
            return None
        
        patternstring = '[:|=]'
        locatorlist = re.split(patternstring, elementlocator)
        locatorlist = ["'" + x.strip() + "'" for x in locatorlist]
        locatorstring = ','.join(locatorlist)
        print(f'Concat String is: {locatorstring}')
        return '(' + locatorstring + ')'
        