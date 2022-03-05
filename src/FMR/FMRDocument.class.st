Class {
	#name : #FMRDocument,
	#superclass : #FMRObject,
	#instVars : [
		'documentString',
		'title',
		'extent',
		'isParseEmphasis',
		'isParseMatchplay'
	],
	#category : #FMR
}

{ #category : #UI }
FMRDocument class >> defaultExtent [ 
^800@300
]

{ #category : #'instance creation' }
FMRDocument class >> on: aSelector [
^self new on: aSelector
]

{ #category : #API }
FMRDocument class >> openBriefHintSheet [
((self on: #recordingHintSheetBrief) extent: 500@350) beTitleFromText openTextWindow

]

{ #category : #API }
FMRDocument class >> openCommonSequences [
((self on: #recordingCommonSequences) extent: 550@460) beTitleFromText beParseMatchplay openTextWindow

]

{ #category : #API }
FMRDocument class >> openFMRFeatures [
((self on: #fmrFeatures) extent: 550@700) beTitleFromText openTextWindow

]

{ #category : #UI }
FMRDocument class >> openHelpWindowWith: text extent: extent [

self openWindowTitle: 'Help - ',(text copyUpTo: Character cr) text: text extent: extent

]

{ #category : #API }
FMRDocument class >> openHintSheet [
((self on: #recordingHintSheet) extent: 600@800) beTitleFromText openTextWindow
]

{ #category : #API }
FMRDocument class >> openRecordingFundamentals [
((self on: #recordingFundamentals) extent: 550@700) beTitleFromText openTextWindow

]

{ #category : #UI }
FMRDocument class >> openWindowTitle: aTitle text: aText extent: aPoint [

(self new
	title: aTitle;
	documentString: aText;
	extent: aPoint)
		openTextWindow
]

{ #category : #utilities }
FMRDocument >> asText [
^self textualise: self documentString
]

{ #category : #API }
FMRDocument >> beParseEmphasis [
self isParseEmphasis: true
]

{ #category : #API }
FMRDocument >> beParseMatchplay [
self isParseMatchplay: true
]

{ #category : #API }
FMRDocument >> beTitleFromText [
self title: (self documentString copyUpTo: Character cr).
self documentString: (self documentString copyAfter: Character cr).
]

{ #category : #accessing }
FMRDocument >> documentString [

	^ documentString
]

{ #category : #accessing }
FMRDocument >> documentString: anObject [

	documentString := anObject
]

{ #category : #accessing }
FMRDocument >> extent [
^extent ifNil: [ 600@300 ]
]

{ #category : #accessing }
FMRDocument >> extent: anObject [

	extent := anObject
]

{ #category : #documents }
FMRDocument >> fmrFeatures [
^'Features of the FMR system
[What does FMR do?]
* lets you record standard singles and doubles foosball matchplay
* by watching a live match or a video recording
* maintain a library of saved matchplay recordings for future access
* generates matchplay statistics from matchplay recordings
* play the publically available source video from which a recording was made
* compare statistics between saved matchplay recordings 

[What events can FMR record?]
* standard singles and doubles matchplay
* possession of the ball on the rods (2-rod, 5-rod, 3-rod) of each team
* goal scored
* time-out, ball-off-table, dead ball, infraction, referee request
* other stoppage of play
* duration of each possession and of pauses in play 
* controlled possession vs uncontrolled possession (using duration)
* teams swapping table sides
* doubles team swapping positions
* can add a comment as an event (e.g. "Wow!")

[What events can''t it record?]
* which puppet the ball is on (just the rod)
* the intention of a player (e.g. did they mean to pass or shoot)
* what type of pass or shot was used
* ball hitting the side or back walls

[What statistics can it generate?]
* matchplay intensity
* goals scored cleanly, by deflection, own-goals
* rod possession count, average duration, total duration, share of possession
* passing, scoring, blocking, stealing and retention percentages
* gameplay events e.g time-outs, ball-off-table

'
]

{ #category : #initialization }
FMRDocument >> initialize [ 
self beParseEmphasis 
]

{ #category : #accessing }
FMRDocument >> isParseEmphasis [
^isParseEmphasis == true
]

{ #category : #accessing }
FMRDocument >> isParseEmphasis: anObject [

	isParseEmphasis := anObject
]

{ #category : #accessing }
FMRDocument >> isParseMatchplay [
^isParseMatchplay == true
]

{ #category : #accessing }
FMRDocument >> isParseMatchplay: anObject [

	isParseMatchplay := anObject
]

{ #category : #initialization }
FMRDocument >> on: aSelector [
^self documentString: (self perform: aSelector)
]

{ #category : #API }
FMRDocument >> openTextWindow [
| textField |

textField := SpTextPresenter new beWrapWord beNotEditable.
textField openWithSpec
	title: 'FMR - ',self title;
	extent: self extent.
textField text: self asText
]

{ #category : #documents }
FMRDocument >> recordingCommonSequences [
^'Common Matchplay Idioms
[Sequence	When you might type it]
{53#}			5-rod pass to 3-rod and score...
{.5}			...then ball goes to other team''s 5-rod for the next kick-off
{3.2}			3-rod shot is blocked by the other team''s defender
{2.2}			2-rod shot is blocked by other team''s defender
{5.5}			5-rod pass is blocked and stolen other team''s 5-rod
{5.5.5}		5-rod pass blocked, but comes back to original 5-rod
{2.52}			2-rod shot deflected off opposing 5 and captured by opposing defender
{2.#}			Defender scores own-goal
{53t3#}		Pass to 3-rod, takes a time-out, restart on 3-rod and scores
{3.2^2}		3-rod shot blocked by 2-rod, goes off table, restart by defender
{5.3.2!.3}		3-rod fails to catch 5-rod pass, jar infraction called, restart on 3-rod
{5.5_5}		5-rod blocks 5-rod, ball goes dead, restart on 5-rod
{53.2s}		Failed 5-rod to 3-rod pass followed by a stoppage in play (e.g. to discuss a jar)...
{>!}			...infraction by team on right side of the table...
{3#} 			...and ball given to other team''s 3-rod who then scores
{<t}			...and then the team on the left of the table calls a time-out
{<:}			...during which the players on the left swap positions
{/}			The game ends
{<>}			...and the teams swap sides
{//}			The match ends			
'
]

{ #category : #documents }
FMRDocument >> recordingFundamentals [
^'Matchplay Recording Fundamentals
[Beginner]
* a match recording is no more than a sequence of matchplay events
* during active play every character you type creates a matchplay event
* type 2,3 or 5 to indicate possession onof the ball on a rod
* type # to indicate a goal scored (recall aid - it''s like goal netting)
* think of the target goal as like another rod on the same team...
* So for a pass-and-score sequence you would type: 53#
* type a dot . when possession changes to the other team 
* after a goal press the Enter key to submit the events to the main history pane
* after a goal type / and Enter to indicate the end of a game
* after a goal type // and Enter to indicate the end of the match

[Novice]
* use the Recording>Match Details menu to set table type, table orientation and team names
* as you record events, check the event colour in the output field
* the colour of the event should match the colour of the puppets
* a matchplay event is either an active play event or a pause event
* active play events are entered sequentially in the Recording Input Field
* for better statistics record as many momentary contacts as you can
* type 2 for a possession on the 2-rod or goalkeeper rod, or a contact with the back wall 
* type t for a time-out during active play
* after a time-out during active play, type the rod number again when play restarts
* you can add a comment after any event using double-quotes, e.g. "Wow!"

[Expert]
* type an s and Enter to indicate a stoppage in active play (other than a time-out)
* type v if you need to pause the video you are recording from - it stops the timer
* record a 2-rod own-goal as the sequence {2.#} to indicate change of possession
* wait to type the rod number when a referee would start their timer
* each matchplay event duration is finalised when you type the next event
* the duration of the possession change event (.) is time when the ball is between two rods'

]

{ #category : #documents }
FMRDocument >> recordingHintSheet [
^'Matchplay Recording Hint Sheet
[Active Play Events
Active Play Events record events that occur during active play and are entered using one keystroke.

Key 		Event								What happens next]
2		Begin possession on 2-rod				Active Play continues
5		Begin possession on 5-rod				Active Play continues
3		Begin possession on 3-rod				Active Play continues
.		Possession changed between teams	Active Play continues
#		Goal scored							Paused Play begins
^		Ball off table							Paused Play begins
_		Dead ball							Paused Play begins
t		Time-out on current rod				Paused Play begins
!		Infraction							Paused Play begins
s		Play stopped for another reason		Paused Play begins

[Paused Play Events
Paused Play Events record events during Paused Play; they are entered with one or two keystrokes,
on their own on a single input line. The angle bracket indicates whether the event
refers to the team on the left side of the table (<) or the team on the right side of the table (>).

Keys		Event]
/			End of game (enter after the last goal of the game)
//			End of match (enter after the last game of the match)
<t	>t		Time-out by team on specified side
<!	>!		Infraction by team on specified side
<r	>r		Referee request by team on specified side
<:	>:		Players in team on the specified side swap positions (doubles)
<>			Teams swaps sides of the table (between games)

[Magic Keys
Magic Keys do not represent matchplay events but provide other functionality. The entered
keystroke does not appear in either the Input or the Output Field.

Key			Action]
?			Open this Hint sheet window
f			Flag the latest event for later review; flagged events are highlighted in the Lines display
p			Pause the matchplay timer so you can pause and rewind the video
z			Zero the matchplay timer but keep it running

'
]

{ #category : #documents }
FMRDocument >> recordingHintSheetBrief [
^'Matchplay Recording Hint Sheet (Beginner)
[You only need to know these five keystrokes to start recording...

Key 		Event								What happens next]
2		Begin possession on 2-rod				Active Play continues
5		Begin possession on 5-rod				Active Play continues
3		Begin possession on 3-rod				Active Play continues
.		Possession changed between teams	Active Play continues
#		Goal scored							Paused Play begins (press Enter)

[...and these two Paused Play commands which end a game or the match...

Key			Event]
/			End of game (enter after the last goal of the game)
//			End of match (enter after the last game of the match)'
]

{ #category : #utilities }
FMRDocument >> textualise: aString [
| tokenStream token |

tokenStream := (aString findTokens: '[]{}' keep: '[]{}') readStream.
^Text streamContents: [ :s |
	[ tokenStream atEnd ] whileFalse: [
		token := tokenStream next.
		token first = $[
			ifTrue: [ self isParseEmphasis
				ifTrue: [ s << (tokenStream next asText addAttribute: TextEmphasis bold). tokenStream next ]
				ifFalse: [ s << token asText ]]
			ifFalse: [ 
				token first = ${
					ifTrue: [ self isParseMatchplay
						ifTrue: [ s << (MatchplayEventPrinter forDocumentation printForSequence: tokenStream next). tokenStream next ]
						ifFalse: [ s << token asText ]]
					ifFalse: [ s << token asText ]]]]
]

{ #category : #accessing }
FMRDocument >> title [

	^ title
]

{ #category : #accessing }
FMRDocument >> title: anObject [

	title := anObject
]
