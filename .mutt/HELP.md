~A              all messages
~b EXPR         messages which contain EXPR in the message body
~B EXPR         messages which contain EXPR in the whole message
~c USER         messages carbon-copied to USER
~C EXPR         message is either to: or cc: EXPR
~D              deleted messages
~d [MIN]-[MAX]  messages with ``date-sent'' in a Date range
~E              expired messages
~e EXPR         message which contains EXPR in the ``Sender'' field
~F              flagged messages
~f USER         messages originating from USER
~g              PGP signed messages
~G              PGP encrypted messages
~h EXPR         messages which contain EXPR in the message header
~k              message contains PGP key material
~i ID           message which match ID in the ``Message-ID'' field
~L EXPR         message is either originated or received by EXPR
~l              message is addressed to a known mailing list
~m [MIN]-[MAX]  message in the range MIN to MAX *)
~n [MIN]-[MAX]  messages with a score in the range MIN to MAX *)
~N              new messages
~O              old messages
~p              message is addressed to you (consults $alternates)
~P              message is from you (consults $alternates)
~Q              messages which have been replied to
~R              read messages
~r [MIN]-[MAX]  messages with ``date-received'' in a Date range
~S              superseded messages
~s SUBJECT      messages having SUBJECT in the ``Subject'' field.
~T              tagged messages
~t USER         messages addressed to USER
~U              unread messages
~v              message is part of a collapsed thread.
~x EXPR         messages which contain EXPR in the `References' field
~y EXPR         messages which contain EXPR in the `X-Label' field
~z [MIN]-[MAX]  messages with a size in the range MIN to MAX *)
~=              duplicated messages (see $duplicate_threads)
