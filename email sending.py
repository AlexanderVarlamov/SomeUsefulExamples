"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 14.06.2023
@time 9:30
"""
import smtplib
import ssl

port = 465  # For SSL
# password = input("Type your password and press enter: ")
password = "SxSwgVm3VZ7QvDCnYfwf"

# Create a secure SSL context
context = ssl.create_default_context()

with smtplib.SMTP_SSL("smtp.mail.ru", port, context=context) as server:
    server.login("test_email.av@inbox.ru", password)
    message = '''
    Test email sending
    '''
    server.sendmail(from_addr="test_email.av@inbox.ru", to_addrs="warlamov@gmail.com", msg=message)
    # TODO: Send email here