Extension { #name : #MorphTreeResizerMorph }

{ #category : #'*FMR' }
MorphTreeResizerMorph >> resizeColumnToFit [
"Resize to fit row cells and header label
	- code blagged from #doubleClick:"

"A double click occurred.
Resize the column to fit all content."
| maxWidth columnHeaderWidth |
self canResizeColumn ifFalse: [^ self].
maxWidth := container getList
	ifEmpty: [ 0 ]
	ifNotEmpty: [ :c | c max: [ :node | (self column rowMorphFor: node) width ]].
columnHeaderWidth := self column header label_ width.
self column currentWidth: (maxWidth max: columnHeaderWidth + 5) + 6.
container resizerChanged
]
