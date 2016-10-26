require_relative 'lib/quake_log_parser'

parser = QuakeLogParser.new(ARGV[0])
parser.parse_log_file
parser.display_game_information