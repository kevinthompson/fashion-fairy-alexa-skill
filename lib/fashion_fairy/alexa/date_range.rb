module FashionFairy
  module Alexa
    class DateRange
      attr_reader :date

      def initialize(date:)
        @date = date
      end

      def include?(date)
        range.include?(date)
      end

      def count
        @count ||= range.to_a.count
      end

      def start_date
        @start_date ||= begin
          if date.nil?
            Date.today
          elsif date.to_s[/WE$/]
            Date.parse(date) + 4.days
          else
            Date.parse(date)
          end
        end
      end

      def end_date
        @end_date ||= begin
          case date.to_s
          when /\d{4}-W\d{1,2}-WE$/
            start_date + 2.days
          when /\d{4}-W\d{1,2}$/, ''
            start_date + 6.days
          else
            start_date
          end
        end
      end

      def to_s
        if start_date == end_date
          if start_date == Date.today
            'today'
          elsif start_date == Date.today + 1.day
            'tomorrow'
          elsif start_date <= Date.today + 6.days
            start_date.strftime("%A")
          else
            "#{start_date.strftime("%A %B #{start_date.day.ordinalize}")}"
          end
        else
          if start_date == Date.today
            if end_date == Date.today + 6.days
              'this week'
            else
              %(
                today through
                #{end_date.strftime("%A %B #{end_date.day.ordinalize}")}
              ).squish
            end
          else
            %(
              #{start_date.strftime("%A %B #{start_date.day.ordinalize}")}
              through
              #{end_date.strftime("%A %B #{end_date.day.ordinalize}")}
            ).squish
          end
        end
      end

      private

      def range
        @range ||= (start_date..end_date)
      end
    end
  end
end
