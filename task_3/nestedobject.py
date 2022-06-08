import json
import sys

def get_value(user_object, key_list):
   for k in key_list:
      user_object = user_object.get(k, None)
      if user_object is None:
          print ("Wrong key --> {}!! Exiting!!!".format(k))
          sys.exit(1)
   return user_object

def main():
  user_obj = input("Enter the object: ")
  key      = input("Enter the key: ")
  try:
   user_obj_json = json.loads(user_obj)
  except json.decoder.JSONDecodeError:
    print('ERROR: Input {} is not valid. Exiting!!!'.format(user_obj))
    sys.exit(1)
  key_list = key.split("/")
  print("Value is:",get_value(user_obj_json,key_list))    

if __name__=='__main__':
    main()
