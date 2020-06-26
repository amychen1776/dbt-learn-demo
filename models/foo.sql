{% set email_metrics = [
    'bounces',
    'clicks',
    'deferrals',
    'deliveries',
    'drops',
    'forwards',
    'opens',
    'prints',
    'spam_reports',
    'unsubscribes'
] %}
with contacts as (
    select *
    from
), email_sends as (
    select *
    from 
), email_metrics as (
    select
        recipient_email_address,
        {% for metric in email_metrics %}
        sum(email_sends.{{ metric }}) as total_{{ metric }},
        count(distinct case when email_sends.{{ metric }} > 0 then email_send_id end) as total_unique_{{ metric }}
        {% if not loop.last %},{% endif %}
        {% endfor %}
    from email_sends
    group by 1
), joined as (
    select
        contacts.*,
        {% for metric in email_metrics %}
        coalesce(email_metrics.total_{{ metrics }}, 0) as total_{{ metrics }},
        coalesce(email_metrics.total_unique_{{ metrics }}, 0) as total_unique_{{ metrics }}
        {% if not loop.last %},{% endif %}
        {% endfor %}
    from contacts
    left join email_metrics
        on contacts.email = email_metrics.recipient_email_address
)
select *
from joined
