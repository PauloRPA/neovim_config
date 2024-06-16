return {
    init_options = {
        html = {
            options = {
                ['output.formatSkip'] = {},
                ['output.formatForce'] = { 'html', 'body' },
                ['output.compactBoolean'] = true,
                ['output.formatLeafNode'] = false,
                ['output.inlineBreak'] = 1,
                ['comment.enabled'] = false,
                ['comment.trigger'] = { 'action' },
                ['comment.after'] = '\n<!-- [ACTION] -->',
            },
        },
        css = {
            options = {
                ['stylesheet.intUnit'] = 'px',
                ['stylesheet.unitAliases'] = { e = 'em', p = '%', x = 'ex', r = 'rem' },
            },
        },
    },
}
