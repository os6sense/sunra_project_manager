# Client Login is a huge bug bear. Requirements:
#
#  - On order to protect against large scale compromise of recorded 
#  -    sessions, either the password (or a seperate key - undecided) should be used
#  -    to encrypt the recordings.
#  - Individual passwords must withstand brute force/dictionary/rainbow table attacks
#  - File encryption keys (if used) have similar requirements.
#  - The encryption key most be recoverable.
#  - The users password must be changable.
#  - Any recordings belonging to the user must be decrypted when the user logs in.
#
# This obviously adds a large amount of complexity to any password and file opperations.
#
# How this works (the plan):
#   - When the booking is set up:
#     - Generate a password for the user.
#     - Keep a copy of the password in clear text (initially)
#     - Generate a key that will be used to encrypt any recordings.
#     - Encrypt the encryption key using the users password.
#   - The booking happens and session recording begins.
#     - after a recording finishes in the background an encrypted version is created using
#       the users encryption key.
#     - The encrypted version is uploaded (whenever) to the webserver.
#     - The webserver is updated with the users:
#       - encrypted password.
#       - encrytped encryption key.
#     - an email is sent out with URL, username and password.
#
# Problems with this design:
#   - An email address cannot be used since multiple people may access the file using the 
#     same username and password.
#   - We ALWAYS have a copy of the clear text username and password on our email system.
#     If someone compromises our email system, they have full access.
#
# ALTERNATIVE SOLUTION:
# Allow the user control of what the username and password is!
#  - The online system, when they first access the URL https://archive.sowhatresearch.com/2r230ewiuweoi/
#  - THEY are prompted to set up a username and password (if they so choose - its not required)
#  - The online system encrypts the files and uses our public key to save a copy of the details
#    (so that we can recover if neccessary)
# BRLLIANT!


class ClientLogin < ActiveRecord::Base
  belongs_to :project

  attr_accessible :login_email,
                  :password,
                  :password_digest,
                  :recoverable,
                  :key_name

  default_scope order('login_email ASC')

  validates :login_email,  :presence => true, :uniqueness => true
  validates :password_digest,  :presence => true
  validates :password,
     :length => { :minimum => 6 }, :if => :password_digest_changed?

  # TODO: upgrade to rails 4 for :validations
  has_secure_password
end
