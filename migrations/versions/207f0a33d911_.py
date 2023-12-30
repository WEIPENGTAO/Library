"""empty message

Revision ID: 207f0a33d911
Revises: 40ff40d3876a
Create Date: 2023-12-30 11:52:49.034358

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '207f0a33d911'
down_revision = '40ff40d3876a'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('email',
    sa.Column('email_id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('email', sa.String(length=45), nullable=False),
    sa.Column('code', sa.String(length=6), nullable=False),
    sa.PrimaryKeyConstraint('email_id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('email')
    # ### end Alembic commands ###
